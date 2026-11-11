<?php
require_once __DIR__ . '/../includes/layout.php';
$u = require_stylist(); $id = (int)$u['id'];
if (is_post()) { csrf_check();
    $t = row('SELECT * FROM tasks WHERE id=? AND stylist_id=?', [(int)post('id'), $id]);
    if ($t && in_array(post('status'), ['pending', 'done'])) {
        q('UPDATE tasks SET status=? WHERE id=?', [post('status'), $t['id']]);
        if (post('status') === 'done' && $t['created_by']) notify((int)$t['created_by'], 'Task Completed', $u['name'] . ' completed: ' . $t['title'], 'success');
        flash('success', post('status') === 'done' ? 'Task marked as done.' : 'Task moved back to pending.');
    } else flash('error', 'Task not found.');
    redirect('stylist/tasks.php');
}
$f = in_array($_GET['f'] ?? '', ['pending', 'done']) ? $_GET['f'] : 'pending';
$list = rows("SELECT t.*, c.name AS by_name FROM tasks t LEFT JOIN users c ON c.id=t.created_by WHERE t.stylist_id=? AND t.status=? ORDER BY CASE t.priority WHEN 'high' THEN 0 WHEN 'normal' THEN 1 ELSE 2 END, t.due_date, t.id DESC", [$id, $f]);
panel_header('My Tasks', $u);
?>
<div class="toolbar"><div class="grow muted">Tasks assigned to you by the salon admin or reception.</div>
 <a class="btn btn-sm <?= $f === 'pending' ? 'btn-gold' : 'btn-ghost' ?>" href="?f=pending">Pending</a><a class="btn btn-sm <?= $f === 'done' ? 'btn-gold' : 'btn-ghost' ?>" href="?f=done">Done</a></div>
<?php if (!$list): ?><div class="box empty"><?= icon('check', 44) ?><p><?= $f === 'pending' ? 'No pending tasks. Great job!' : 'No completed tasks yet.' ?></p></div><?php endif;
foreach ($list as $t): $late = $t['status'] === 'pending' && $t['due_date'] && $t['due_date'] < date('Y-m-d'); ?>
 <div class="notif <?= $t['status'] === 'pending' ? 'unread' : '' ?>"><div class="ni"><?= icon($t['status'] === 'done' ? 'check' : ($t['priority'] === 'high' ? 'alert' : 'clock'), 20) ?></div>
  <div><h4><?= e($t['title']) ?> <span class="badge <?= $t['priority'] === 'high' ? 'b-cancelled' : 'b-pending' ?>"><?= e(ucfirst($t['priority'])) ?></span><?= $late ? ' <span class="badge b-low">Overdue</span>' : '' ?></h4>
   <p class="small"><?= nl2br(e($t['details'])) ?></p><small><?= $t['due_date'] ? 'Due ' . fdate($t['due_date'], 'd M Y') : 'No due date' ?><?= $t['by_name'] ? ' &middot; Assigned by ' . e($t['by_name']) : '' ?></small></div>
  <form method="post"><?= csrf_field() ?><input type="hidden" name="id" value="<?= $t['id'] ?>"><input type="hidden" name="status" value="<?= $t['status'] === 'done' ? 'pending' : 'done' ?>"><button class="btn btn-xs <?= $t['status'] === 'done' ? 'btn-ghost' : 'btn-gold' ?>"><?= $t['status'] === 'done' ? 'Undo' : 'Mark done' ?></button></form></div>
<?php endforeach; panel_footer();
