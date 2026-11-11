<?php
require_once __DIR__ . '/../includes/layout.php'; require_once __DIR__ . '/../includes/invoice_view.php';
$u = require_client();
$a = row(appt_query('a.id=? AND a.client_id=?'), [(int)($_GET['id'] ?? 0), $u['id']]);
if (!$a) { flash('error', 'Invoice not found.'); redirect('user/payments.php'); }
$p = row('SELECT * FROM payments WHERE appointment_id=?', [$a['id']]);
if (!$p) {
    $s = row('SELECT price FROM services WHERE id=?', [$a['service_id']]);
    $p = [
        'invoice_no' => 'INV-' . $a['id'],
        'amount' => $s['price'] ?? 0,
        'method' => 'Paid',
        'status' => 'Completed',
        'paid_at' => $a['appt_date'],
        'created_at' => $a['appt_date']
    ];
}
panel_header('Invoice', $u); render_invoice($a, $p); panel_footer();