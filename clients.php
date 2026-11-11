<?php
require_once __DIR__ . '/../includes/layout.php';
$u = require_stylist(); $id = (int)$u['id'];
$clients = rows("SELECT c.id,c.name,c.phone,c.email,c.notes,c.pref_stylist_id, ps.name AS pref_service, COUNT(a.id) AS visits, MAX(a.appt_date) AS last_visit,
  SUM(CASE WHEN a.status='completed' THEN 1 ELSE 0 END) AS done
  FROM appointments a JOIN users c ON c.id=a.client_id LEFT JOIN services ps ON ps.id=c.pref_service_id
  WHERE a.stylist_id=? AND a.status<>'cancelled' GROUP BY c.id,c.name,c.phone,c.email,c.notes,c.pref_stylist_id,ps.name ORDER BY last_visit DESC", [$id]);
$hist = []; foreach (rows(appt_query('a.stylist_id=?', 'a.appt_date DESC'), [$id]) as $a) $hist[$a['client_id']][] = fdate($a['appt_date'], 'd M Y') . ' - ' . $a['service'] . ' (' . $a['status'] . ')';
panel_header('My Clients', $u);
?>
<div class="toolbar"><input type="search" class="grow" placeholder="Search client by name, phone or email…" data-search="#clTbl"><span class="muted small"><?= count($clients) ?> clients</span></div>
<div class="box"><?php if (!$clients): ?><div class="empty"><?= icon('users', 44) ?><p>No clients have booked with you yet.</p></div><?php else: ?>
<div class="tbl-wrap"><table id="clTbl"><thead><tr><th>Client</th><th>Contact</th><th>Visits</th><th>Last Visit</th><th>Preferences</th><th>History</th></tr></thead><tbody>
<?php foreach ($clients as $c): ?><tr><td><b><?= e($c['name']) ?></b><?= $c['pref_stylist_id'] == $id ? '<br><span class="badge b-success">Prefers you</span>' : '' ?></td>
 <td class="small"><?= e($c['phone']) ?><br><span class="muted"><?= e($c['email']) ?></span></td><td><?= (int)$c['visits'] ?> <small class="muted">(<?= (int)$c['done'] ?> done)</small></td><td><?= fdate($c['last_visit'], 'd M Y') ?></td>
 <td class="small"><?= $c['pref_service'] ? 'Service: ' . e($c['pref_service']) . '<br>' : '' ?><span class="muted"><?= e($c['notes'] ?: '-') ?></span></td>
 <td class="small"><?= implode('<br>', array_map('e', array_slice($hist[$c['id']] ?? [], 0, 4))) ?></td></tr><?php endforeach; ?></tbody></table></div><?php endif; ?></div>
<?php panel_footer();
