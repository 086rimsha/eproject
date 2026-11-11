<?php
// ============ Elegance Salon - Configuration ============
// XAMPP / WAMP default settings. Change if your MySQL has a password.
define('DB_DRIVER', getenv('SALON_DRIVER') ?: 'mysql');   // 'mysql' or 'sqlite'
define('DB_HOST', 'localhost');
define('DB_NAME', 'elegance_salon');
define('DB_USER', 'root');
define('DB_PASS', '');
define('SQLITE_FILE', __DIR__ . '/database/salon.sqlite');

define('SITE_NAME', 'Elegance Salon');
define('SITE_PHONE', '+92 300 1234567');
define('SITE_EMAIL', 'hello@elegancesalon.com');
define('SITE_ADDRESS', '12 Khayaban-e-Ittehad, DHA Phase 6, Karachi, Pakistan');
define('CURRENCY', 'Rs ');

// Base URL auto-detect (works in any sub-folder like http://localhost/salon/)
$__root = str_replace('\\', '/', realpath(__DIR__));
$__doc  = str_replace('\\', '/', realpath($_SERVER['DOCUMENT_ROOT'] ?? '') ?: '');
$__base = ($__doc && strpos($__root, $__doc) === 0) ? substr($__root, strlen($__doc)) : '';
define('BASE_URL', rtrim($__base, '/'));
date_default_timezone_set('Asia/Karachi');
