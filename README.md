# Elegance Salon Management System (PHP + MySQL)

## Run (XAMPP / WAMP)
1. Copy the `salon` folder to `C:\xampp\htdocs\`
2. Start Apache and MySQL in XAMPP
3. Open http://localhost/salon/ (database, tables and demo data are created automatically)
   - Different MySQL password? Edit config.php. Optional: import database/schema.sql in phpMyAdmin.

## Demo logins
Client: client / client123 | Admin: admin / admin123 | Receptionist: reception / reception123 | Stylist: sophia / stylist123

## Access rules
Login ya Register kiye baghair koi bhi website page (Home, About, Services, Stylists, Contact) open nahi hota.
Guest sirf `login.php` aur `register.php` dekh sakta hai; baqi sab pages login par redirect ho jate hain.

## Services for Women & Men
- Every service has an audience: Women, Men, or Women & Men (set it in Admin > Services > "For").
- Home page and Services page have a Women / Men switch; the booking page shows who each service is for.
- Existing databases are upgraded automatically on first load (adds the `audience` column and 7 men's services; your data is untouched).

## Update: Public home page + Stylist Panel
- Home, About, Services, Stylists and Contact are now open to everyone. Booking and all dashboards ask the visitor to login first, then take them straight to the page they wanted.
- Stylists now have their own panel (`/stylist`): Dashboard, My Appointments, My Calendar (+ .ics export for Google Calendar / iCal), Shift & Services, Commission & Earnings, My Tasks, My Clients (history + preferences), My Reviews, Notifications, Profile.
- Admin/Receptionist can assign tasks to stylists from **Stylist Tasks** (`/admin/tasks.php`). The `tasks` table is created automatically.
