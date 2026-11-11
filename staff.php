<?php
require_once __DIR__ . '/../includes/layout.php';
$u = require_role('admin');
if (is_post()) { csrf_check(); $act = post('action'); $id = (int)post('id');
    if ($act === 'save') {
        $name = post('name'); $email = strtolower(post('email')); $uname = strtolower(post('username')) ?: strstr($email, '@', true); $rmap = ['1' => 'admin', '2' => 'receptionist', '3' => 'stylist']; $rv = post('role'); $rv = $rmap[$rv] ?? $rv; $role = in_array($rv, ['admin', 'receptionist', 'stylist'], true) ? $rv : 'stylist';
        if ($id == $u['id']) $role = 'admin'; // admin can never lock themself out
        if (!$name || !filter_var($email, FILTER_VALIDATE_EMAIL)) flash('error', 'Name and a valid email are required.');
        elseif (val('SELECT 1 FROM users WHERE (email=? OR username=?) AND id<>?', [$email, $uname, $id])) flash('error', 'Email or username already exists.');
        elseif (!$id && strlen($_POST['password'] ?? '') < 6) flash('error', 'Password (min 6 characters) is required for new staff.');
        else {
            if ($id) { q('UPDATE users SET name=?,email=?,username=?,phone=?,role=? WHERE id=?', [$name, $email, $uname, post('phone'), $role, $id]); if (post('password')) q('UPDATE users SET password=? WHERE id=?', [password_hash($_POST['password'], PASSWORD_DEFAULT), $id]); }
            else { q('INSERT INTO users (name,username,email,phone,password,role) VALUES (?,?,?,?,?,?)', [$name, $uname, $email, post('phone'), password_hash($_POST['password'], PASSWORD_DEFAULT), $role]); $id = insert_id(); }
            // photo: a newly chosen file wins, otherwise keep the current one
            $photo = post('photo');
            $f = $_FILES['photo_file'] ?? null;
            if ($f && ($f['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE) {
                $info = ($f['error'] === UPLOAD_ERR_OK && is_uploaded_file($f['tmp_name'])) ? @getimagesize($f['tmp_name']) : false;
                $ext = $info ? ([IMAGETYPE_JPEG => 'jpg', IMAGETYPE_PNG => 'png', IMAGETYPE_WEBP => 'webp'][$info[2]] ?? null) : null;
                if (!$ext) flash('error', 'Photo must be a JPG, PNG or WEBP image.');
                elseif ($f['size'] > 4 * 1024 * 1024) flash('error', 'Photo is too large (max 4 MB).');
                else {
                    $dir = __DIR__ . '/../assets/uploads/staff'; if (!is_dir($dir)) @mkdir($dir, 0775, true);
                    $fn = 'staff-' . $id . '-' . bin2hex(random_bytes(5)) . '.' . $ext;
                    if (@move_uploaded_file($f['tmp_name'], "$dir/$fn")) $photo = url("assets/uploads/staff/$fn");
                    else flash('error', 'Could not save the photo. Check that assets/uploads is writable.');
                }
            }
            q('DELETE FROM stylist_profiles WHERE user_id=?', [$id]); q('DELETE FROM stylist_services WHERE stylist_id=?', [$id]);
            if ($role === 'stylist') {
                q('INSERT INTO stylist_profiles (user_id,title,specialties,bio,photo,experience,commission_rate,work_days,start_time,end_time,shift_note) VALUES (?,?,?,?,?,?,?,?,?,?,?)', [$id, post('title'), post('specialties'), post('bio'), $photo, (int)post('experience'), (int)post('commission_rate'), implode(',', array_map('intval', (array)($_POST['work_days'] ?? []))), post('start_time') ?: '10:00', post('end_time') ?: '19:00', post('shift_note')]);
                foreach ((array)($_POST['service_ids'] ?? []) as $sid) q('INSERT INTO stylist_services VALUES (?,?)', [$id, (int)$sid]);
            }
            flash('success', 'Staff member saved.');
        }
    } elseif ($act === 'toggle' && $id != $u['id']) { q('UPDATE users SET status=1-status WHERE id=?', [$id]); flash('success', 'Staff status changed.'); }
    elseif ($act === 'delete' && $id != $u['id']) { if (val('SELECT 1 FROM appointments WHERE stylist_id=?', [$id])) { q('UPDATE users SET status=0 WHERE id=?', [$id]); flash('success', 'Staff has appointment history, so the account was deactivated.'); } else { q('DELETE FROM users WHERE id=?', [$id]); q('DELETE FROM stylist_profiles WHERE user_id=?', [$id]); q('DELETE FROM stylist_services WHERE stylist_id=?', [$id]); flash('success', 'Staff deleted.'); } }
    redirect('admin/staff.php');
}
$staff = rows("SELECT u.*, p.title,p.specialties,p.bio,p.photo,p.experience,p.commission_rate,p.work_days,p.start_time,p.end_time,p.shift_note,(SELECT GROUP_CONCAT(service_id) FROM stylist_services WHERE stylist_id=u.id) AS service_ids FROM users u LEFT JOIN stylist_profiles p ON p.user_id=u.id WHERE u.role<>'client' ORDER BY u.id");
$services = rows('SELECT id,name FROM services WHERE active=1');
panel_header('Staff Management', $u);
?>
<div class="toolbar"><input type="search" class="grow" placeholder="Search staff…" data-search="#stTbl"><button class="btn btn-gold btn-sm" data-open="stModal" data-reset><?= icon('plus', 16) ?> Add Staff</button></div>
<div class="box"><div class="tbl-wrap"><table id="stTbl"><thead><tr><th>Name</th><th>Role / Access</th><th>Contact</th><th>Schedule / Shift</th><th>Commission</th><th>Status</th><th>Actions</th></tr></thead><tbody>
<?php foreach ($staff as $s): $j = $s; unset($j['password']); $j['password'] = ''; ?><tr><td><b><?= e($s['name']) ?></b><br><small class="muted"><?= e($s['title'] ?: '@' . $s['username']) ?></small></td><td><span class="badge b-<?= e($s['role']) ?>"><?= ['admin'=>'1','receptionist'=>'2','stylist'=>'3'][$s['role']] ?? '' ?> - <?= e(ucfirst($s['role'])) ?></span></td><td><?= e($s['phone']) ?><br><small class="muted"><?= e($s['email']) ?></small></td>
<td class="small"><?= $s['role'] === 'stylist' ? days_label($s['work_days']) . '<br>' . ftime($s['start_time']) . ' - ' . ftime($s['end_time']) . '<br><span class="muted">' . e($s['shift_note']) . '</span>' : '-' ?></td><td><?= $s['role'] === 'stylist' ? $s['commission_rate'] . '%' : '-' ?></td><td><?= $s['status'] ? '<span class="badge b-ok">Active</span>' : '<span class="badge b-cancelled">Inactive</span>' ?></td>
<td><div class="acts"><button class="btn btn-ghost btn-xs" data-open="stModal" data-json='<?= e(json_encode($j)) ?>'><?= icon('edit', 13) ?></button>
<?php if ($s['id'] != $u['id']): ?><form method="post"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="id" value="<?= $s['id'] ?>"><button class="btn btn-ghost btn-xs"><?= $s['status'] ? 'Disable' : 'Enable' ?></button></form><form method="post"><?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= $s['id'] ?>"><button class="btn btn-red btn-xs" data-confirm="Delete this staff member?"><?= icon('trash', 13) ?></button></form><?php endif; ?></div></td></tr><?php endforeach; ?></tbody></table></div></div>
<?php modal_open('stModal', 'Staff Member', 'lg'); ?>
<form method="post" enctype="multipart/form-data" data-validate novalidate><?= csrf_field() ?><input type="hidden" name="action" value="save"><input type="hidden" name="id">
 <div class="row3"><div class="fg"><label>Full Name *</label><input type="text" name="name" required></div><div class="fg"><label>Email *</label><input type="email" name="email" required></div><div class="fg"><label>Phone</label><input type="tel" name="phone"></div></div>
 <div class="row3"><div class="fg"><label>Username</label><input type="text" name="username" placeholder="auto from email"></div><div class="fg"><label>Role</label><select name="role" id="roleSel"><option value="admin">1 - Admin (full access)</option><option value="receptionist">2 - Receptionist</option><option value="stylist" selected>3 - Stylist</option></select><small class="muted" id="roleHint"></small></div><div class="fg"><label>Password</label><input type="password" name="password" placeholder="Blank = keep current"></div></div>
 <div id="stylistFields"><div class="row3"><div class="fg"><label>Job Title</label><input type="text" name="title"></div><div class="fg"><label>Commission %</label><input type="number" name="commission_rate" min="0" max="100" value="20"></div><div class="fg"><label>Experience (yrs)</label><input type="number" name="experience" min="0" value="1"></div></div>
 <div class="row3"><div class="fg"><label>Shift Start</label><input type="time" name="start_time" value="10:00"></div><div class="fg"><label>Shift End</label><input type="time" name="end_time" value="19:00"></div><div class="fg"><label>Shift Note</label><input type="text" name="shift_note" placeholder="e.g. Morning shift"></div></div>
 <div class="fg"><label>Working Days</label><div class="daybox"><?php foreach ([1 => 'Mon', 2 => 'Tue', 3 => 'Wed', 4 => 'Thu', 5 => 'Fri', 6 => 'Sat', 7 => 'Sun'] as $n => $d): ?><label><input type="checkbox" name="work_days[]" value="<?= $n ?>" <?= $n < 7 ? 'checked' : '' ?>><span><?= $d ?></span></label><?php endforeach; ?></div></div>
 <div class="fg"><label>Services assigned</label><div class="daybox"><?php foreach ($services as $s): ?><label><input type="checkbox" name="service_ids[]" value="<?= $s['id'] ?>"><span><?= e($s['name']) ?></span></label><?php endforeach; ?></div></div>
 <div class="row2"><div class="fg"><label>Specialties</label><input type="text" name="specialties"></div><div class="fg"><label>Photo</label><div class="photo-pick"><img id="stPhotoPrev" alt="" hidden><div><input type="file" name="photo_file" id="stPhotoFile" accept="image/jpeg,image/png,image/webp"><small class="muted">JPG, PNG or WEBP, max 4 MB. Leave empty to keep the current photo.</small></div></div><input type="hidden" name="photo"></div></div><div class="fg"><label>Bio</label><textarea name="bio" style="min-height:70px"></textarea></div></div>
 <button class="btn btn-gold btn-block">Save Staff Member</button></form><?php modal_close(); ?>
<script>const rs=document.getElementById('roleSel'),sf=document.getElementById('stylistFields');const RH={admin:'Role 1: full access to every admin page (staff, reports, inventory, payments).',receptionist:'Role 2: appointments, clients, calendar and payments.',stylist:'Role 3: own stylist panel only (schedule, tasks, clients, earnings).'};const t=()=>{sf.style.display=rs.value==='stylist'?'':'none';document.getElementById('roleHint').textContent=RH[rs.value]||'';};rs.onchange=t;t();document.getElementById('stModal').addEventListener('filled',t);document.querySelector('[data-open=stModal][data-reset]').addEventListener('click',()=>setTimeout(t,10));
const pf=document.getElementById('stPhotoFile'),pv=document.getElementById('stPhotoPrev'),ph=document.querySelector('#stModal [name=photo]');
const showPrev=src=>{if(src){pv.src=src;pv.hidden=false}else{pv.removeAttribute('src');pv.hidden=true}};
document.getElementById('stModal').addEventListener('filled',()=>{pf.value='';showPrev(ph.value)});
document.querySelector('[data-open=stModal][data-reset]').addEventListener('click',()=>setTimeout(()=>{pf.value='';showPrev('')},10));
pf.addEventListener('change',()=>{const f=pf.files[0];if(!f)return showPrev(ph.value);if(f.size>4*1024*1024){alert('Photo is too large (max 4 MB).');pf.value='';return showPrev(ph.value)}showPrev(URL.createObjectURL(f))});</script>
<?php panel_footer();
