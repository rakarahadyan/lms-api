-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Sep 2025 pada 09.54
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dblms`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('draft','published','archived') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `courses`
--

INSERT INTO `courses` (`id`, `title`, `description`, `category`, `instructor_id`, `cover_image`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Pemrograman Frontend Modern dengan React dan Angular', 'Belajar membangun aplikasi web modern menggunakan React dan Angular dengan praktik terbaik industri', 'PROGRAMMING', 1, NULL, '2025-04-01', '2025-06-30', 'published', '2025-09-05 06:29:25', '2025-09-05 07:55:48'),
(2, 'Creative Marketing Strategy', 'Strategi pemasaran kreatif untuk era digital', 'CREATIVE MARKETING', 2, NULL, '2025-04-15', '2025-07-15', 'published', '2025-09-05 06:29:25', '2025-09-05 07:55:58'),
(3, 'Management SDM Modern', 'Teknik manajemen sumber daya manusia di era modern', 'MANAGEMENT SDM', NULL, NULL, '2025-05-01', '2025-08-01', 'published', '2025-09-05 06:29:25', '2025-09-05 18:26:31'),
(4, 'Belajar Node JS', 'Kursus dasar Node JS untuk intermediate', 'PROGRAMMING', 2, 'http', '2025-09-10', '2025-10-10', 'draft', '2025-09-05 15:33:11', '2025-09-05 16:42:33'),
(6, 'Belajar React Native', 'Kursus dasar React Native untuk pemula', 'PROGRAMMING', NULL, '', '2025-09-10', '2025-10-10', 'draft', '2025-09-05 16:43:19', '2025-09-06 07:42:38'),
(7, 'Expertise React', 'Deskripsi eact', 'PROGRAMMING', NULL, '', '2025-09-01', '2025-09-30', 'draft', '2025-09-06 07:29:11', '2025-09-06 07:29:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `modules`
--

CREATE TABLE `modules` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `order_index` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `modules`
--

INSERT INTO `modules` (`id`, `course_id`, `title`, `description`, `content`, `order_index`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Introduction to Modern Frontend', 'Pengenalan teknologi frontend modern', NULL, 1, 'active', '2025-09-05 06:29:25', '2025-09-05 06:29:25'),
(2, 1, 'React Fundamentals', 'Dasar-dasar React.js', NULL, 2, 'active', '2025-09-05 06:29:25', '2025-09-05 06:29:25'),
(3, 1, 'Angular Basics', 'Pengenalan Angular framework', NULL, 3, 'active', '2025-09-05 06:29:25', '2025-09-05 06:29:25'),
(4, 2, 'Digital Marketing Basics', 'Dasar-dasar digital marketing', NULL, 1, 'active', '2025-09-05 06:29:25', '2025-09-05 06:29:25'),
(5, 2, 'Content Strategy', 'Strategi pembuatan konten', NULL, 2, 'active', '2025-09-05 06:29:25', '2025-09-05 06:29:25'),
(6, 3, 'HR Management Principles', 'Prinsip-prinsip manajemen HR', NULL, 1, 'active', '2025-09-05 06:29:25', '2025-09-05 06:29:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text DEFAULT NULL,
  `type` enum('info','success','warning','error') DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `is_read`, `created_at`) VALUES
(1, 3, 'Course Update', 'Module baru telah ditambahkan ke course React', 'info', 0, '2025-09-05 06:29:25'),
(2, 4, 'Assignment Due', 'Tugas Angular akan berakhir dalam 3 hari', 'warning', 0, '2025-09-05 06:29:25'),
(3, 3, 'Congratulations!', 'Selamat! Anda telah menyelesaikan course Creative Marketing', 'success', 0, '2025-09-05 06:29:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `scheduled_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `schedules`
--

INSERT INTO `schedules` (`id`, `course_id`, `title`, `description`, `scheduled_date`, `start_time`, `end_time`, `created_at`) VALUES
(1, 1, 'React Workshop', 'Workshop intensif React.js', '2025-09-10', '09:00:00', '12:00:00', '2025-09-05 06:29:25'),
(2, 1, 'Angular Session', 'Sesi pembelajaran Angular', '2025-09-15', '14:00:00', '17:00:00', '2025-09-05 06:29:25'),
(3, 2, 'Marketing Strategy Review', 'Review strategi marketing', '2025-09-12', '10:00:00', '11:30:00', '2025-09-05 06:29:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `scores`
--

CREATE TABLE `scores` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `points` varchar(11) NOT NULL,
  `attempt` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `scores`
--

INSERT INTO `scores` (`id`, `user_id`, `course_id`, `points`, `attempt`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '95.00', 1, '2025-09-05 06:29:25', '2025-09-05 06:29:25'),
(4, 4, 2, '78.00', 1, '2025-09-05 06:29:25', '2025-09-05 06:29:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','instructor','admin') DEFAULT 'student',
  `profile_image` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `profile_image`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Juliana ', 'admin@adhivasindo.co.id', '$2a$12$EBeQzatEUOVGvOzGfb/1LeNYdG632yrrNz0zA9rUWiG7nBf5hdKYa', 'admin', 'profile1.jpg', NULL, NULL, '2025-09-05 06:29:23', '2025-09-06 05:54:58'),
(2, 'Dr. Joseph Instructor', 'joseph@adhivasindo.co.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'instructor', 'profile2.jpg', NULL, NULL, '2025-09-05 06:29:23', '2025-09-05 06:29:23'),
(3, 'Arif Student', 'arif@student.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'student', NULL, NULL, NULL, '2025-09-05 06:29:23', '2025-09-05 06:29:23'),
(4, 'Sari Student', 'sari@student.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'student', NULL, NULL, NULL, '2025-09-05 06:29:23', '2025-09-05 06:29:23'),
(5, 'ahmad', 'ahmad@example.com', '$2y$10$ILAuWhB/8cN6FOJEUtkF2etnPh606Hf2mvTUiWNQtTInxjw3P6pXO', 'student', NULL, NULL, NULL, '2025-09-06 03:46:13', '2025-09-06 03:46:13'),
(6, 'Programming Foundation', 'john@company.com', '$2y$10$nOOOaEsR14ky.meWFShoH.swt5DnWe1OX8Ese6ZAKDNTiAiC8WJga', 'student', NULL, NULL, NULL, '2025-09-06 03:49:25', '2025-09-06 03:49:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_courses`
--

CREATE TABLE `user_courses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `enrolled_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `progress` varchar(10) DEFAULT '0',
  `status` enum('enrolled','in_progress','completed','dropped') DEFAULT 'enrolled',
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user_courses`
--

INSERT INTO `user_courses` (`id`, `user_id`, `course_id`, `enrolled_at`, `progress`, `status`, `completed_at`) VALUES
(1, 3, 1, '2025-09-05 06:29:25', '75.50', 'in_progress', NULL),
(2, 4, 1, '2025-09-05 06:29:25', '45.20', 'in_progress', NULL),
(3, 3, 2, '2025-09-05 06:29:25', '100.00', 'completed', NULL),
(4, 4, 3, '2025-09-05 06:29:25', '30.00', 'in_progress', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_module_progress`
--

CREATE TABLE `user_module_progress` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `progress_percentage` decimal(5,2) DEFAULT 0.00,
  `started_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL,
  `status` enum('not_started','in_progress','completed') DEFAULT 'not_started',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user_module_progress`
--

INSERT INTO `user_module_progress` (`id`, `user_id`, `module_id`, `progress_percentage`, `started_at`, `completed_at`, `status`, `updated_at`) VALUES
(1, 3, 1, 100.00, '2025-09-05 06:29:25', NULL, 'completed', '2025-09-05 06:29:25'),
(2, 3, 2, 80.00, '2025-09-05 06:29:25', NULL, 'in_progress', '2025-09-05 06:29:25'),
(3, 4, 1, 100.00, '2025-09-05 06:29:25', NULL, 'completed', '2025-09-05 06:29:25'),
(4, 4, 2, 60.00, '2025-09-05 06:29:25', NULL, 'in_progress', '2025-09-05 06:29:25');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_instructor` (`instructor_id`);

--
-- Indeks untuk tabel `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_course_id` (`course_id`),
  ADD KEY `idx_order` (`order_index`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_type` (`type`);

--
-- Indeks untuk tabel `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_course_id` (`course_id`),
  ADD KEY `idx_scheduled_date` (`scheduled_date`);

--
-- Indeks untuk tabel `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_module_id` (`course_id`),
  ADD KEY `idx_score` (`points`),
  ADD KEY `course_id` (`course_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`);

--
-- Indeks untuk tabel `user_courses`
--
ALTER TABLE `user_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_course_id` (`course_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indeks untuk tabel `user_module_progress`
--
ALTER TABLE `user_module_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_module` (`user_id`,`module_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_module_id` (`module_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `scores`
--
ALTER TABLE `scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `user_courses`
--
ALTER TABLE `user_courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `user_module_progress`
--
ALTER TABLE `user_module_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `fk_instructors` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `modules`
--
ALTER TABLE `modules`
  ADD CONSTRAINT `modules_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_courses`
--
ALTER TABLE `user_courses`
  ADD CONSTRAINT `user_courses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_courses_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_module_progress`
--
ALTER TABLE `user_module_progress`
  ADD CONSTRAINT `user_module_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_module_progress_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
