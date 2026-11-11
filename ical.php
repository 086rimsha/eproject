<?php
// Export this stylist's confirmed appointments as an .ics file (Google Calendar / Apple iCal import)
require_once __DIR__ . '/../includes/functions.php';
$u = require_stylist();
$esc = fn($s) => str_replace(["\\", ";", ",", "\n"], ["\\\\", "\\;", "\\,", "\\n"], (string)$s);
$out = "BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:-//Elegance Salon//Stylist Calendar//EN\r\nCALSCALE:GREGORIAN\r\nX-WR-CALNAME:" . $esc(SITE_NAME . ' - ' . $u['name']) . "\r\n";
foreach (rows(appt_query("a.stylist_id=? AND a.status='confirmed'", 'a.appt_date, a.appt_time'), [$u['id']]) as $a) {
    $d = str_replace('-', '', $a['appt_date']);
    $out .= "BEGIN:VEVENT\r\nUID:appt-{$a['id']}@elegance-salon\r\nDTSTAMP:" . gmdate('Ymd\THis\Z') . "\r\nDTSTART:{$d}T" . str_replace(':', '', $a['appt_time']) . "00\r\nDTEND:{$d}T" . str_replace(':', '', $a['end_time']) . "00\r\n"
        . 'SUMMARY:' . $esc($a['service'] . ' - ' . $a['client']) . "\r\nDESCRIPTION:" . $esc('Ref ' . $a['ref'] . ($a['notes'] ? ' | ' . $a['notes'] : '')) . "\r\nLOCATION:" . $esc(SITE_ADDRESS) . "\r\nEND:VEVENT\r\n";
}
$out .= "END:VCALENDAR\r\n";
header('Content-Type: text/calendar; charset=utf-8');
header('Content-Disposition: attachment; filename="elegance-my-appointments.ics"');
echo $out;
