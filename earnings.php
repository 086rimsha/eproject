<?php
require_once __DIR__ . '/../includes/layout.php';
$u = require_stylist(); $id = (int)$u['id'];
$rate = (int)val('SELECT commission_rate FROM stylist_profiles WHERE user_id=?', [$id]);
$m = preg_match('/^\d{4}-\d{2}$/', $_GET['m'] ?? '') ? $_GET['m'] : 'all';
$where = "a.stylist_id=? AND a.status='completed'"; $par = [$id];
if ($m !== 'all') { $where .= ' AND a.appt_date LIKE ?'; $par[] = $m . '%'; }
$done = rows(appt_query($where, 'a.appt_date DESC'), $par);
$rev = array_sum(array_column($done, 'price')); $comm = $rev * $rate / 100;
$months = array_column(rows("SELECT DISTINCT substr(appt_date,1,7) AS m FROM appointments WHERE stylist_id=? AND status='completed' ORDER BY m DESC", [$id]), 'm');
$bySvc = []; foreach ($done as $a) { $bySvc[$a['service']]['n'] = ($bySvc[$a['service']]['n'] ?? 0) + 1; $bySvc[$a['service']]['r'] = ($bySvc[$a['service']]['r'] ?? 0) + $a['price']; }
uasort($bySvc, fn($x, $y) => $y['r'] <=> $x['r']);
panel_header('Commission & Earnings', $u);
?>
<div class="toolbar"><div class="grow muted">Commission is <?= $rate ?>% of each completed service.</div>
 <select onchange="location='?m='+this.value"><option value="all">All time</option><?php foreach ($months as $mm): ?><option value="<?= e($mm) ?>" <?= $m === $mm ? 'selected' : '' ?>><?= date('F Y', strtotime($mm . '-01')) ?></option><?php endforeach; ?></select></div>
<div class="stats"><div class="stat"><div class="si"><?= icon('check', 26) ?></div><div><b><?= count($done) ?></b><span>Services Performed</span></div></div><div class="stat blue"><div class="si"><?= icon('money', 26) ?></div><div><b><?= money($rev) ?></b><span>Revenue Generated</span></div></div><div class="stat green"><div class="si"><?= icon('card', 26) ?></div><div><b><?= money($comm) ?></b><span>My Commission</span></div></div></div>
<div class="grid g2">
<div class="box"><div class="box-h"><h3>Commission Breakdown</h3></div><?php if (!$done): ?><div class="empty"><?= icon('money', 40) ?><p>No completed services in this period.</p></div><?php else: ?><div class="tbl-wrap"><table><thead><tr><th>Date</th><th>Client</th><th>Service</th><th>Price</th><th>Commission</th></tr></thead><tbody><?php foreach ($done as $a): ?><tr><td><?= fdate($a['appt_date'], 'd M Y') ?></td><td><?= e($a['client']) ?></td><td><?= e($a['service']) ?></td><td><?= money($a['price']) ?></td><td><b><?= money($a['price'] * $rate / 100) ?></b></td></tr><?php endforeach; ?></tbody></table></div><?php endif; ?></div>
<div class="box" style="margin-top:0"><div class="box-h"><h3>By Service</h3></div><?php if (!$bySvc) echo '<p class="muted small">No data yet.</p>'; foreach ($bySvc as $n => $s): ?><div class="mini"><div><h4><?= e($n) ?></h4><small class="muted"><?= $s['n'] ?> times &middot; <?= money($s['r']) ?> revenue</small></div><b><?= money($s['r'] * $rate / 100) ?></b></div><?php endforeach; ?></div>
</div>
<?php panel_footer();
