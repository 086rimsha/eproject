-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2026 at 08:10 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elegance_salon`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `ref` varchar(20) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `stylist_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `appt_date` varchar(10) NOT NULL,
  `appt_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `price` int(11) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'confirmed',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `ref`, `client_id`, `stylist_id`, `service_id`, `appt_date`, `appt_time`, `end_time`, `price`, `status`, `notes`, `created_at`) VALUES
(1, 'ES261111001', 7, 4, 1, '2026-10-28', '11:00', '11:45', 1500, 'completed', '', '2026-11-11 06:49:24'),
(2, 'ES261111002', 7, 3, 3, '2026-11-02', '14:00', '15:00', 3000, 'completed', '', '2026-11-11 06:49:24'),
(3, 'ES261111003', 8, 5, 4, '2026-11-04', '12:00', '13:00', 3500, 'completed', '', '2026-11-11 06:49:24'),
(4, 'ES261111004', 9, 3, 5, '2026-11-06', '10:00', '12:00', 8000, 'completed', '', '2026-11-11 06:49:24'),
(5, 'ES261111005', 8, 4, 2, '2026-11-08', '15:00', '16:00', 2000, 'completed', '', '2026-11-11 06:49:24'),
(6, 'ES261111006', 9, 6, 5, '2026-11-09', '17:00', '19:00', 8000, 'completed', '', '2026-11-11 06:49:24'),
(7, 'ES261111007', 7, 5, 4, '2026-11-13', '14:00', '15:00', 3500, 'confirmed', '', '2026-11-11 06:49:24'),
(8, 'ES261111008', 8, 3, 3, '2026-11-16', '13:00', '14:00', 3000, 'confirmed', '', '2026-11-11 06:49:24'),
(9, 'ES261111009', 9, 4, 1, '2026-11-17', '16:00', '16:45', 1500, 'completed', '', '2026-11-11 06:49:24');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `appointment_id`, `client_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 7, 5, 'Absolutely loved it, the staff are so professional!', '2026-11-11 06:49:24'),
(2, 2, 7, 4, 'Great service and very relaxing atmosphere.', '2026-11-11 06:49:24'),
(3, 3, 8, 5, 'Absolutely loved it, the staff are so professional!', '2026-11-11 06:49:24'),
(4, 4, 9, 4, 'Great service and very relaxing atmosphere.', '2026-11-11 06:49:24');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `sku` varchar(30) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `reorder_level` int(11) NOT NULL DEFAULT 5,
  `unit_cost` int(11) NOT NULL DEFAULT 0,
  `supplier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `name`, `category`, `sku`, `quantity`, `reorder_level`, `unit_cost`, `supplier_id`) VALUES
(1, 'Keratin Shampoo 1L', 'Hair Products', 'HP-001', 18, 6, 1800, 1),
(2, 'Hair Color Tube - Brown', 'Hair Products', 'HP-002', 4, 8, 650, 1),
(3, 'Nail Polish Gel Set', 'Nail Supplies', 'NS-001', 25, 10, 2200, 2),
(4, 'Facial Mask Pack (10)', 'Skin Care', 'SC-001', 3, 5, 1500, 2),
(5, 'Disposable Towels (100)', 'Consumables', 'CN-001', 40, 15, 900, 1),
(6, 'Massage Oil 500ml', 'Spa', 'SP-001', 9, 5, 1400, 2),
(7, 'hair color', 'color', '', 11, 5, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `subject` varchar(150) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `name`, `email`, `subject`, `message`, `created_at`) VALUES
(1, 'Zara Ahmed', 'zara@elegance.com', 'hair cutting', 'nice work', '2026-11-11 07:07:28');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(150) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `type` varchar(20) DEFAULT 'info',
  `is_read` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `is_read`, `created_at`) VALUES
(1, 7, 'Welcome to Elegance Salon', 'Your account is ready. Book your first appointment today!', 'info', 0, '2026-11-11 06:49:24'),
(2, 7, 'Appointment Confirmed', 'Your upcoming appointment has been confirmed.', 'success', 0, '2026-11-11 06:49:24'),
(3, 9, 'Payment Received', 'Thank you! Your payment was received. Invoice INV-1009 is available in your account.', 'success', 0, '2026-11-11 07:03:08'),
(4, 7, 'Appointment Rescheduled', 'Your Facial appointment is now on 13 Nov 2026 at 02:00 PM.', 'success', 0, '2026-11-11 07:06:26'),
(5, 5, 'Appointment Rescheduled', 'Facial moved to 13 Nov 2026 at 02:00 PM.', 'info', 1, '2026-11-11 07:06:26');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `invoice_no` varchar(20) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `method` varchar(20) DEFAULT 'cash',
  `status` varchar(20) DEFAULT 'paid',
  `paid_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `appointment_id`, `invoice_no`, `amount`, `method`, `status`, `paid_at`) VALUES
(1, 1, 'INV-1001', 1500, 'card', 'paid', '2026-11-11 06:49:24'),
(2, 2, 'INV-1002', 3000, 'online', 'paid', '2026-11-11 06:49:24'),
(3, 3, 'INV-1003', 3500, 'cash', 'paid', '2026-11-11 06:49:24'),
(4, 4, 'INV-1004', 8000, 'card', 'paid', '2026-11-11 06:49:24'),
(5, 5, 'INV-1005', 2000, 'online', 'paid', '2026-11-11 06:49:24'),
(6, 6, 'INV-1006', 8000, 'cash', 'paid', '2026-11-11 06:49:24'),
(7, 9, 'INV-1009', 1500, 'cash', 'paid', '2026-11-11 07:03:08');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `qty` int(11) NOT NULL,
  `total_cost` int(11) NOT NULL,
  `status` varchar(20) DEFAULT 'ordered',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `benefits` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 60,
  `image` varchar(255) DEFAULT NULL,
  `icon` varchar(40) DEFAULT NULL,
  `audience` varchar(10) NOT NULL DEFAULT 'women',
  `active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `category`, `description`, `benefits`, `price`, `duration`, `image`, `icon`, `audience`, `active`) VALUES
(1, 'Manicure', 'Nails', 'A complete hand treatment: shaping, cuticle care, exfoliation, massage and a flawless polish finish.', 'Soft hands|Healthy nails|Relaxing massage', 1500, 45, 'https://images.unsplash.com/photo-1610992015732-2449b76344bc?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'hand', 'unisex', 1),
(2, 'Pedicure', 'Nails', 'Luxury foot spa with soak, scrub, callus care, massage and polish for beautiful, rested feet.', 'Smooth feet|Deep relaxation|Callus removal', 2000, 60, 'https://images.unsplash.com/photo-1519415510236-718bdfcd89c8?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'foot', 'unisex', 1),
(3, 'Hair Styling', 'Hair', 'Cut, blow-dry and styling tailored to your face shape, from everyday elegance to party glam.', 'Custom look|Heat protection|Long-lasting finish', 3000, 60, 'https://images.unsplash.com/photo-1562322140-8baeececf3df?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'scissors', 'women', 1),
(4, 'Facial', 'Skin', 'Deep-cleansing facial with steam, extraction, mask and massage to restore natural glow.', 'Glowing skin|Deep cleanse|Anti-ageing', 3500, 60, 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'sparkle', 'unisex', 1),
(5, 'Hair Color', 'Hair', 'Global colour, highlights and balayage using ammonia-free premium colour.', 'Vibrant shade|Hair-safe formula|Colour consultation', 8000, 120, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'drop', 'unisex', 1),
(6, 'Hair Spa & Treatment', 'Hair', 'Nourishing keratin spa that repairs damage, adds shine and tames frizz.', 'Frizz control|Deep conditioning|Shine boost', 4500, 75, 'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'leaf', 'unisex', 1),
(7, 'Bridal Makeup', 'Makeup', 'Complete bridal makeup with trial consultation, airbrush finish and hair setting.', 'Airbrush finish|Long-wear|Trial included', 25000, 150, 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'crown', 'women', 1),
(8, 'Relaxing Body Massage', 'Spa', 'Full-body aromatherapy massage to melt away stress and muscle tension.', 'Stress relief|Better sleep|Aromatherapy', 6000, 60, 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'lotus', 'unisex', 1),
(9, 'Waxing & Threading', 'Skin', 'Gentle, hygienic hair removal with soothing post-care for smooth skin.', 'Smooth finish|Gentle formula|Quick service', 1200, 30, 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'feather', 'women', 1),
(10, 'Men\'s Haircut & Styling', 'Hair', 'Precision cut, wash and styling by our barbers, tailored to your head shape and lifestyle.', 'Sharp finish|Style advice|Hair wash included', 1500, 45, 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'scissors', 'men', 1),
(11, 'Beard Trim & Shaping', 'Grooming', 'Expert beard sculpting with hot towel, clean line-up and conditioning oil for a defined look.', 'Defined lines|Hot towel|Beard oil', 800, 30, 'https://images.unsplash.com/photo-1621605815971-fbc98d665033?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'razor', 'men', 1),
(12, 'Classic Hot Towel Shave', 'Grooming', 'Traditional straight-razor shave with steaming towels, rich lather and a soothing aftershave.', 'Smooth shave|Skin soothing|Deep relaxation', 1200, 30, 'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'razor', 'men', 1),
(13, 'Men\'s Facial & Cleanup', 'Skin', 'Deep-cleansing facial made for men\'s skin: exfoliation, de-tan, extraction and hydration.', 'Deep cleanse|De-tan|Fresh skin', 2500, 45, 'https://www.swagmee.com/static/version1777640067/frontend/Swagmee/Theme/en_US/images/o3-power-mask-2030-men.jpg', 'sparkle', 'men', 1),
(15, 'Scalp Massage & Hair Spa', 'Spa', 'Relaxing head, neck and shoulder massage with a nourishing scalp treatment.', 'Stress relief|Healthy scalp|Better sleep', 2000, 40, 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'lotus', 'men', 1),
(16, 'Groom Package', 'Grooming', 'Complete groom makeover: haircut, beard styling, facial and a relaxing massage for the big day.', 'Full makeover|Trial included|Priority booking', 12000, 120, 'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?auto=format&fit=crop&w=1000&q=85&ixlib=rb-4.0.3', 'crown', 'men', 1);

-- --------------------------------------------------------

--
-- Table structure for table `stylist_profiles`
--

CREATE TABLE `stylist_profiles` (
  `user_id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `specialties` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `experience` int(11) DEFAULT 1,
  `commission_rate` int(11) DEFAULT 20,
  `work_days` varchar(30) DEFAULT '1,2,3,4,5,6',
  `start_time` varchar(5) DEFAULT '10:00',
  `end_time` varchar(5) DEFAULT '19:00',
  `shift_note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stylist_profiles`
--

INSERT INTO `stylist_profiles` (`user_id`, `title`, `specialties`, `bio`, `photo`, `experience`, `commission_rate`, `work_days`, `start_time`, `end_time`, `shift_note`) VALUES
(3, 'Creative Director & Hair Stylist', 'Hair Styling, Hair Color, Bridal', 'Sophia has 12 years of experience crafting editorial and bridal hair for Karachi\'s most memorable occasions.', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=900&q=88&ixlib=rb-4.0.3', 12, 25, '1,2,3,4,5,6', '10:00', '19:00', 'Morning + Evening'),
(4, 'Senior Nail Artist', 'Manicure, Pedicure, Nail Art', 'Ayesha is our nail artisan, known for flawless gel finishes and relaxing spa pedicures.', 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=900&q=88&ixlib=rb-4.0.3', 8, 20, '2,3,4,5,6,7', '11:00', '20:00', 'Mid-day Shift'),
(5, 'Skin & Facial Specialist', 'Facial, Skin Care, Waxing', 'Zara is a certified esthetician who customises every facial to your skin\'s needs.', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=900&q=88&ixlib=rb-4.0.3', 6, 20, '1,3,4,5,6,7', '10:00', '18:00', 'Day Shift'),
(6, 'Master Barber & Colorist', 'Hair Styling, Hair Color, Beard', 'Daniel blends classic barbering with modern colour techniques for flawless, lasting results.', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=900&q=88&ixlib=rb-4.0.3', 10, 22, '1,2,3,4,5,6', '12:00', '21:00', 'Evening Shift');

-- --------------------------------------------------------

--
-- Table structure for table `stylist_services`
--

CREATE TABLE `stylist_services` (
  `stylist_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stylist_services`
--

INSERT INTO `stylist_services` (`stylist_id`, `service_id`) VALUES
(3, 3),
(3, 5),
(3, 6),
(3, 7),
(3, 10),
(3, 16),
(4, 1),
(4, 2),
(5, 4),
(5, 7),
(5, 8),
(5, 9),
(5, 13),
(5, 15),
(6, 3),
(6, 5),
(6, 6),
(6, 10),
(6, 11),
(6, 12),
(6, 15),
(6, 16);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `phone`, `email`, `address`) VALUES
(1, 'Glam Beauty Traders', '0321-1000001', 'sales@glambeauty.pk', 'Saddar, Karachi'),
(2, 'Pro Salon Supplies', '0321-1000002', 'orders@prosalon.pk', 'Gulberg, Lahore');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `stylist_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `details` text DEFAULT NULL,
  `due_date` varchar(10) DEFAULT NULL,
  `priority` varchar(10) DEFAULT 'normal',
  `status` varchar(20) DEFAULT 'pending',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'client',
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `dob` varchar(12) DEFAULT NULL,
  `pref_stylist_id` int(11) DEFAULT NULL,
  `pref_service_id` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `phone`, `password`, `role`, `gender`, `address`, `dob`, `pref_stylist_id`, `pref_service_id`, `notes`, `status`, `created_at`) VALUES
(1, 'Admin Elegance', 'admin', 'admin@elegance.com', '0300-1111111', '$2y$10$YY5dPsFNrKs28.gWeGRoN..Fm/OQpR1kulzUrqJq99QBWahhK1Mb2', 'admin', 'female', 'Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:23'),
(2, 'Hina Receptionist', 'reception', 'reception@elegance.com', '0300-2222222', '$2y$10$9EgZr3bYwoTKGha5p16gNuds8TjVmu5QIjm1GDLSJrD5DfxJD91za', 'receptionist', 'female', 'Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:23'),
(3, 'Sophia Khan', 'sophia', 'sophia@elegance.com', '0301-3000001', '$2y$10$ZxnAbOhNcozs/eicnDeGuuBJlcTtA1d5dHSwY6oGeBRBHxOAbbfsS', 'stylist', 'female', 'Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:23'),
(4, 'Ayesha Malik', 'ayesha', 'ayesha@elegance.com', '0301-3000002', '$2y$10$6U7AH9YkDPrKmWMBPdaxwu4gJEWn4hPXWfjteORmjGiXplS0TFWmy', 'stylist', 'female', 'Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:23'),
(5, 'Zara Ahmed', 'zara', 'zara@elegance.com', '0301-3000003', '$2y$10$GZ8sDKU3fneiwRecaEOHSuWxO.la9STN902h8IlSyvka0LR2jq7XO', 'stylist', 'female', 'Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:24'),
(6, 'Daniel Raza', 'daniel', 'daniel@elegance.com', '0301-3000004', '$2y$10$nU3GbxTvrY1JTN/TsbVoIOtpdMt7GYJc6gSMZ6rlvc69p3p5WFfdi', 'stylist', 'male', 'Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:24'),
(7, 'Demo Client', 'client', 'client@demo.com', '0333-4444444', '$2y$10$.BWapXlsC2el8YWT6YiusOVPedUd3HZ1bTaf9m8yfm/J.cyMarM1y', 'client', 'female', 'Clifton, Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:24'),
(8, 'Mariam Ali', 'mariam', 'mariam@demo.com', '0333-5555555', '$2y$10$Q9YMjUbpTztVlRjGELeojO82nRB41iGxMp89UZ9z7c3KxMA2xl/NG', 'client', 'female', 'Gulshan, Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:24'),
(9, 'Fatima Noor', 'fatima', 'fatima@demo.com', '0333-6666666', '$2y$10$jCx937C01P4rmqR/NauLR.z8w8.2hygkhxU4M8zyunChMTJ1hLKnq', 'client', 'female', 'North Nazimabad, Karachi', NULL, NULL, NULL, NULL, 1, '2026-11-11 06:49:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stylist_profiles`
--
ALTER TABLE `stylist_profiles`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `stylist_services`
--
ALTER TABLE `stylist_services`
  ADD PRIMARY KEY (`stylist_id`,`service_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
