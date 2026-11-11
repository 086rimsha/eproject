<?php
require_once __DIR__ . '/../includes/layout.php';
$u = require_stylist(); $id = (int)$u['id'];
$p = row('SELECT * FROM stylist_profiles WHERE user_id=?', [$id]);
$svcs = rows('SELECT s.* FROM stylist_services ss JOIN services s ON s.id=ss.service_id WHERE ss.stylist_id=? AND s.active=1 ORDER BY s.name', [$id]);
$wd = explode(',', (string)($p['work_days'] ?? '')); $names = [1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday', 4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday', 7 => 'Sunday'];
$mon = strtotime('monday this week');
panel_header('Shift & Services', $u);
?>
<div class="grid g2">
 <div class="box"><div class="box-h"><h3>This Week's Shifts</h3></div><div class="tbl-wrap"><table><thead><tr><th>Day</th><th>Date</th><th>Shift</th><th>Bookings</th></tr></thead><tbody>
 <?php foreach ($names as $n => $label): $d = date('Y-m-d', strtotime('+' . ($n - 1) . ' days', $mon)); $on = in_array((string)$n, $wd);
   $b = (int)val("SELECT COUNT(*) FROM appointments WHERE stylist_id=? AND appt_date=? AND status<>'cancelled'", [$id, $d]); ?>
   <tr><td><b><?= $label ?></b></td><td><?= fdate($d, 'd M') ?></td><td><?= $on ? ftime($p['start_time']) . ' - ' . ftime($p['end_time']) : '<span class="badge b-cancelled">Off</span>' ?></td><td><?= $on ? $b : '-' ?></td></tr>
 <?php endforeach; ?></tbody></table></div>
 <p class="hint"><?= icon('user', 15) ?> <?= e($p['shift_note'] ?? '') ?: 'Shifts are set by the salon admin. Contact the admin to request a change.' ?></p></div>
 <div class="box" style="margin-top:0"><div class="box-h"><h3>Services Assigned to Me</h3></div>
 <?php if (!$svcs): ?><p class="muted small">No services assigned yet.</p><?php endif; foreach ($svcs as $s): ?>
   <div class="mini"><div><h4><?= e($s['name']) ?></h4><small class="muted"><?= e($s['category']) ?> &middot; <?= (int)$s['duration'] ?> min</small></div><b><?= money($s['price']) ?></b></div>
 <?php endforeach; ?>
 <div class="lbl mt2">Specialties</div><p class="small"><?= e($p['specialties'] ?? '-') ?></p>
 <div class="lbl mt2">Commission Rate</div><p class="small"><b><?= (int)($p['commission_rate'] ?? 0) ?>%</b> of every completed service</p></div>
</div>
<?php panel_footer();
