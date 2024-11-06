-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 06, 2024 at 08:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sms_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `name` text NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `type`, `email`, `password`, `name`, `class_id`, `phone`) VALUES
(113, 'teacher', 'teacher@example.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Teacher', NULL, '12356789'),
(114, 'student', 'gopi@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'gopika', 16, ''),
(115, 'teacher', 'Teacher2@gmail.com', '$2y$10$vGQlPFx0lFZjcJc99R1zpeKv9OoTcK/FcS/0ahTxcAw/n4RcKmgTi', 'Teacher2', NULL, '12345678'),
(116, 'student', 'kiran@gmail.com', 'e67e90269bee36b00561dbf31d056482', 'kiran', 16, '');

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `id` int(11) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `course_id` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `question` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`id`, `teacher_id`, `course_id`, `class_id`, `question`, `created_at`) VALUES
(19, 113, 17, 16, 'Explain Data Preprocessing Techniques.', '2024-11-06 15:41:10'),
(20, 113, 19, 16, 'explain iot', '2024-11-06 17:44:19');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `attendance_month` text NOT NULL,
  `attendance_value` longtext NOT NULL,
  `modified_date` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `std_id` int(11) NOT NULL,
  `current_session` timestamp NOT NULL DEFAULT current_timestamp(),
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `attendance_month`, `attendance_value`, `modified_date`, `std_id`, `current_session`, `course_id`) VALUES
(95, '2024-11-14', 'Present', '2024-11-06 01:24:17', 114, '2024-11-05 19:54:17', 17),
(96, '2024-11-01', 'Absent', '2024-11-06 21:12:06', 114, '2024-11-06 15:41:30', 17),
(97, '2024-11-01', 'Present', '2024-11-06 21:12:06', 116, '2024-11-06 15:41:30', 17),
(98, '2024-11-14', 'Present', '2024-11-06 21:13:37', 114, '2024-11-06 15:43:37', 18),
(99, '2024-11-14', 'Absent', '2024-11-06 21:13:37', 116, '2024-11-06 15:43:37', 18);

-- --------------------------------------------------------

--
-- Table structure for table `campus_functions`
--

CREATE TABLE `campus_functions` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `function_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `function_time_from` time NOT NULL,
  `function_time_to` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campus_functions`
--

INSERT INTO `campus_functions` (`id`, `title`, `description`, `function_date`, `created_at`, `function_time_from`, `function_time_to`) VALUES
(3, 'annual day', 'Annual Day Celebrations', '2024-11-15', '2024-11-05 19:51:39', '09:30:00', '17:30:00'),
(4, 'Annual day', 'enjoy this Annual day', '2024-11-01', '2024-11-06 15:38:09', '09:01:00', '16:00:00'),
(5, 'Annual day', 'enjoy this Annual day', '2024-11-01', '2024-11-06 15:38:25', '09:01:00', '16:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `section` varchar(50) NOT NULL,
  `added_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `title`, `section`, `added_date`) VALUES
(16, '1', '', '2024-11-05'),
(17, '2', '', '2024-11-05');

-- --------------------------------------------------------

--
-- Table structure for table `communication`
--

CREATE TABLE `communication` (
  `id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `communication`
--

INSERT INTO `communication` (`id`, `teacher_id`, `student_id`, `parent_id`, `message`, `timestamp`, `course_id`) VALUES
(27, 113, 114, 17, 'hlo', '2024-11-06 17:27:06', 17),
(28, 113, 114, 17, 'hlo', '2024-11-06 17:33:53', 17),
(29, 113, 114, 17, 'not reading well', '2024-11-06 17:34:11', 17);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `category` text NOT NULL,
  `duration` text NOT NULL,
  `date` datetime NOT NULL,
  `image` text NOT NULL,
  `teacher_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `class_id`, `name`, `category`, `duration`, `date`, `image`, `teacher_id`) VALUES
(17, 16, 'pds', 'ds', '5hrs', '2024-11-20 01:04:00', 'java.com', 113),
(18, 16, 'java', 'programming', '5hrs', '2024-11-21 09:01:00', 'java.com', 113),
(19, 16, 'dast', 'iot', '5hrs', '2024-11-07 13:04:00', 'java.com', 115);

-- --------------------------------------------------------

--
-- Table structure for table `metadata`
--

CREATE TABLE `metadata` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `meta_key` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `metadata`
--

INSERT INTO `metadata` (`id`, `item_id`, `meta_key`, `meta_value`) VALUES
(1, 2, 'section', '3'),
(2, 2, 'section', '4'),
(3, 7, 'day_name', 'monday'),
(4, 7, 'teacher_id', '2'),
(5, 7, 'subject_id', '19'),
(6, 7, 'period_id', '5'),
(23, 16, 'from', '08:30'),
(24, 16, 'to', '09:15'),
(25, 17, 'from', '09:15'),
(26, 17, 'to', '10:00'),
(27, 5, 'from', '07:00'),
(28, 5, 'to', '07:45'),
(29, 6, 'from', '07:45'),
(30, 6, 'to', '08:30'),
(31, 18, 'class_id', '1'),
(32, 18, 'section_id', '4'),
(33, 18, 'teacher_id', '2'),
(34, 18, 'period_id', '5'),
(35, 18, 'day_name', 'tuesday'),
(36, 18, 'subject_id', '19'),
(37, 7, 'class_id', '1'),
(38, 7, 'section_id', '4'),
(39, 20, 'class_id', '1'),
(40, 20, 'section_id', '4'),
(41, 20, 'teacher_id', '1'),
(42, 20, 'period_id', '16'),
(43, 20, 'day_name', 'wednesday'),
(44, 20, 'subject_id', '19'),
(45, 21, 'class_id', '2'),
(46, 21, 'section_id', '3'),
(47, 21, 'teacher_id', '2'),
(48, 21, 'period_id', '17'),
(49, 21, 'day_name', 'sunday'),
(50, 21, 'subject_id', '20'),
(51, 22, 'class_id', '2'),
(52, 22, 'section_id', '4'),
(53, 22, 'teacher_id', '2'),
(54, 22, 'period_id', '6'),
(55, 22, 'day_name', 'tuesday'),
(56, 22, 'subject_id', '19'),
(57, 23, 'class_id', '2'),
(58, 23, 'section_id', '3'),
(59, 23, 'teacher_id', '2'),
(60, 23, 'period_id', '17'),
(61, 23, 'day_name', 'monday'),
(62, 23, 'subject_id', '19'),
(63, 26, 'amount', '500'),
(64, 26, 'status', 'success'),
(65, 26, 'student_id', '20'),
(66, 26, 'month', 'September'),
(67, 27, 'amount', '500'),
(68, 27, 'status', 'success'),
(69, 27, 'student_id', '20'),
(70, 27, 'month', 'October'),
(71, 28, 'class', '1'),
(72, 28, 'subject', '19'),
(73, 28, 'file_attachment', 'login.php'),
(74, 29, 'class', '2'),
(75, 29, 'subject', '19'),
(76, 29, 'file_attachment', 'index.php'),
(77, 1, 'period_time', '09:00 AM - 09:45 AM'),
(78, 1, 'day_name', 'monday'),
(79, 1, 'subject_id', '19'),
(80, 7, 'period_time', '10:30 AM - 11:15 AM'),
(81, 7, 'day_name', 'tuesday'),
(82, 7, 'course_id', '4'),
(83, 6, 'day_name', 'monday'),
(84, 6, 'period_time', '09:00 AM - 09:45 AM'),
(85, 6, 'course_id', ''),
(86, 6, 'day_name', 'tuesday'),
(87, 6, 'period_time', '09:00 AM - 09:45 AM'),
(88, 6, 'course_id', ''),
(89, 6, 'day_name', 'wednesday'),
(90, 6, 'period_time', '09:00 AM - 09:45 AM'),
(91, 6, 'course_id', ''),
(92, 6, 'day_name', 'thursday'),
(93, 6, 'period_time', '09:00 AM - 09:45 AM'),
(94, 6, 'course_id', ''),
(95, 6, 'day_name', 'friday'),
(96, 6, 'period_time', '09:00 AM - 09:45 AM'),
(97, 6, 'course_id', ''),
(98, 6, 'day_name', 'saturday'),
(99, 6, 'period_time', '09:00 AM - 09:45 AM'),
(100, 6, 'course_id', ''),
(101, 6, 'day_name', 'monday'),
(102, 6, 'period_time', '09:45 AM - 10:30 AM'),
(103, 6, 'course_id', ''),
(104, 6, 'day_name', 'monday'),
(105, 6, 'period_time', '10:30 AM - 11:15 AM'),
(106, 6, 'course_id', ''),
(107, 6, 'day_name', 'monday'),
(108, 6, 'period_time', '11:15 AM - 12:00 PM'),
(109, 6, 'course_id', ''),
(110, 6, 'day_name', 'monday'),
(111, 6, 'period_time', '12:00 PM - 12:45 PM'),
(112, 6, 'course_id', ''),
(113, 6, 'day_name', 'monday'),
(114, 6, 'period_time', '01:00 PM - 01:45 PM'),
(115, 6, 'course_id', ''),
(116, 6, 'day_name', 'monday'),
(117, 6, 'period_time', '01:45 PM - 02:30 PM'),
(118, 6, 'course_id', ''),
(119, 6, 'day_name', 'monday'),
(120, 6, 'period_time', '02:30 PM - 03:15 PM'),
(121, 6, 'course_id', ''),
(122, 6, 'day_name', 'monday'),
(123, 6, 'period_time', '03:15 PM - 04:00 PM'),
(124, 6, 'course_id', ''),
(125, 11, 'day_name', 'monday'),
(126, 11, 'period_time', '09:00 AM - 09:45 AM'),
(127, 11, 'course_id', ''),
(128, 11, 'day_name', 'tuesday'),
(129, 11, 'period_time', '09:00 AM - 09:45 AM'),
(130, 11, 'course_id', ''),
(131, 11, 'day_name', 'wednesday'),
(132, 11, 'period_time', '09:00 AM - 09:45 AM'),
(133, 11, 'course_id', ''),
(134, 11, 'day_name', 'thursday'),
(135, 11, 'period_time', '09:00 AM - 09:45 AM'),
(136, 11, 'course_id', ''),
(137, 11, 'day_name', 'friday'),
(138, 11, 'period_time', '09:00 AM - 09:45 AM'),
(139, 11, 'course_id', ''),
(140, 11, 'day_name', 'saturday'),
(141, 11, 'period_time', '09:00 AM - 09:45 AM'),
(142, 11, 'course_id', ''),
(143, 11, 'day_name', 'monday'),
(144, 11, 'period_time', '09:45 AM - 10:30 AM'),
(145, 11, 'course_id', ''),
(146, 11, 'day_name', 'monday'),
(147, 11, 'period_time', '10:30 AM - 11:15 AM'),
(148, 11, 'course_id', ''),
(149, 11, 'day_name', 'monday'),
(150, 11, 'period_time', '11:15 AM - 12:00 PM'),
(151, 11, 'course_id', ''),
(152, 11, 'day_name', 'monday'),
(153, 11, 'period_time', '12:00 PM - 12:45 PM'),
(154, 11, 'course_id', ''),
(155, 11, 'day_name', 'monday'),
(156, 11, 'period_time', '01:00 PM - 01:45 PM'),
(157, 11, 'course_id', ''),
(158, 11, 'day_name', 'monday'),
(159, 11, 'period_time', '01:45 PM - 02:30 PM'),
(160, 11, 'course_id', ''),
(161, 11, 'day_name', 'monday'),
(162, 11, 'period_time', '02:30 PM - 03:15 PM'),
(163, 11, 'course_id', ''),
(164, 11, 'day_name', 'monday'),
(165, 11, 'period_time', '03:15 PM - 04:00 PM'),
(166, 11, 'course_id', ''),
(167, 90, 'class', '6'),
(168, 90, 'file_attachment', 'footer.php'),
(169, 91, 'class', '6'),
(170, 91, 'file_attachment', 'login.php'),
(171, 92, 'class', '6'),
(172, 92, 'file_attachment', 'header.php'),
(173, 93, 'class', '6'),
(174, 93, 'file_attachment', 'README.md'),
(175, 94, 'file_attachment', 'logout.php'),
(176, 95, 'file_attachment', 'final report pdf.pdf'),
(177, 96, 'class', '3'),
(178, 96, 'file_attachment', 'Table_of_Contents.pdf'),
(179, 97, 'class', '6'),
(180, 97, 'file_attachment', 'index.php'),
(181, 98, 'class', '6'),
(182, 98, 'file_attachment', 'image.png'),
(183, 99, 'file_attachment', 'final report pdf (1).pdf'),
(184, 151, 'file_attachment', 'wscc mid2.docx'),
(185, 152, 'file_attachment', 'header.php'),
(186, 153, 'file_attachment', 'login.php'),
(187, 154, 'file_attachment', 'footer.php'),
(188, 155, 'class', '16'),
(189, 155, 'file_attachment', 'header.php'),
(190, 156, 'file_attachment', 'login.php'),
(191, 16, 'day_name', 'monday'),
(192, 16, 'period_time', '09:00 AM - 09:45 AM'),
(193, 16, 'course_id', ''),
(194, 16, 'day_name', 'tuesday'),
(195, 16, 'period_time', '09:00 AM - 09:45 AM'),
(196, 16, 'course_id', ''),
(197, 16, 'day_name', 'wednesday'),
(198, 16, 'period_time', '09:00 AM - 09:45 AM'),
(199, 16, 'course_id', ''),
(200, 16, 'day_name', 'thursday'),
(201, 16, 'period_time', '09:00 AM - 09:45 AM'),
(202, 16, 'course_id', ''),
(203, 16, 'day_name', 'friday'),
(204, 16, 'period_time', '09:00 AM - 09:45 AM'),
(205, 16, 'course_id', ''),
(206, 16, 'day_name', 'saturday'),
(207, 16, 'period_time', '09:00 AM - 09:45 AM'),
(208, 16, 'course_id', ''),
(209, 16, 'day_name', 'monday'),
(210, 16, 'period_time', '09:45 AM - 10:30 AM'),
(211, 16, 'course_id', ''),
(212, 16, 'day_name', 'monday'),
(213, 16, 'period_time', '10:30 AM - 11:15 AM'),
(214, 16, 'course_id', ''),
(215, 16, 'day_name', 'monday'),
(216, 16, 'period_time', '11:15 AM - 12:00 PM'),
(217, 16, 'course_id', ''),
(218, 16, 'day_name', 'monday'),
(219, 16, 'period_time', '12:00 PM - 12:45 PM'),
(220, 16, 'course_id', ''),
(221, 16, 'day_name', 'monday'),
(222, 16, 'period_time', '01:00 PM - 01:45 PM'),
(223, 16, 'course_id', ''),
(224, 16, 'day_name', 'monday'),
(225, 16, 'period_time', '01:45 PM - 02:30 PM'),
(226, 16, 'course_id', ''),
(227, 16, 'day_name', 'monday'),
(228, 16, 'period_time', '02:30 PM - 03:15 PM'),
(229, 16, 'course_id', ''),
(230, 16, 'day_name', 'monday'),
(231, 16, 'period_time', '03:15 PM - 04:00 PM'),
(232, 16, 'course_id', '');

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE `parents` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_email` varchar(100) NOT NULL,
  `parent_phone` varchar(15) DEFAULT NULL,
  `password` text NOT NULL,
  `child_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parents`
--

INSERT INTO `parents` (`id`, `type`, `parent_name`, `parent_email`, `parent_phone`, `password`, `child_id`) VALUES
(17, 'parent', 'gopikamother', 'gopikamother@gmail.com', '987654321', '827ccb0eea8a706c4c34a16891f84e7b', 114),
(18, 'parent', 'kiranfather', 'kiranfather@gmail.com', '987654321', 'e0e48ac1d994ab0d705ab3c2b041402a', 116);

-- --------------------------------------------------------

--
-- Table structure for table `periods`
--

CREATE TABLE `periods` (
  `id` int(11) NOT NULL,
  `period_name` varchar(255) NOT NULL,
  `period_order` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `author` int(11) NOT NULL DEFAULT 1,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `type` varchar(100) NOT NULL,
  `publish_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(50) NOT NULL,
  `parent` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `author`, `title`, `description`, `type`, `publish_date`, `modified_date`, `status`, `parent`, `class_id`, `course_id`) VALUES
(155, 1, 'pds chapter 1', '', 'study-material', '2024-11-05 19:46:21', '2024-11-05 19:46:21', '', 0, NULL, 0),
(156, 1, 'sss', '', 'study-material', '2024-11-05 19:48:55', '2024-11-05 19:48:55', '', 0, 16, 17);

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `exam_type` varchar(50) NOT NULL,
  `score` decimal(5,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`id`, `student_id`, `course_id`, `exam_type`, `score`, `created_at`) VALUES
(103, 114, 17, 'FA1', 78.00, '2024-11-05 19:36:47'),
(104, 114, 18, 'FA1', 87.00, '2024-11-06 15:42:36'),
(105, 116, 18, 'FA1', 98.00, '2024-11-06 15:42:36'),
(106, 114, 17, 'FA1', 78.00, '2024-11-06 15:42:47'),
(107, 116, 17, 'FA1', 87.00, '2024-11-06 15:42:47'),
(108, 114, 19, 'FA1', 87.00, '2024-11-06 15:43:01'),
(109, 116, 19, 'FA1', 56.00, '2024-11-06 15:43:01');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `title`) VALUES
(2, 'Seciton B'),
(3, 'Section C'),
(4, 'Section D');

-- --------------------------------------------------------

--
-- Table structure for table `studentanswers`
--

CREATE TABLE `studentanswers` (
  `id` int(11) NOT NULL,
  `assignment_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `answer` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentanswers`
--

INSERT INTO `studentanswers` (`id`, `assignment_id`, `student_id`, `answer`, `submitted_at`) VALUES
(4, 19, 114, 'Data Cleaning', '2024-11-06 17:43:25');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_classes`
--

CREATE TABLE `teacher_classes` (
  `teacher_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_classes`
--

INSERT INTO `teacher_classes` (`teacher_id`, `class_id`) VALUES
(113, 16),
(115, 16);

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `day` varchar(20) NOT NULL,
  `time_slot` varchar(100) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usermeta`
--

CREATE TABLE `usermeta` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `meta_key` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usermeta`
--

INSERT INTO `usermeta` (`id`, `user_id`, `meta_key`, `meta_value`) VALUES
(1, 25, 'dob', '1997-09-27'),
(2, 25, 'mobile', '1234567891'),
(3, 25, 'payment_method', 'online'),
(4, 25, 'class', '2'),
(5, 25, 'address', 'Gomitnagar, Lucknow'),
(6, 25, 'country', 'India'),
(7, 25, 'state', 'UP'),
(8, 25, 'zip', '226010'),
(9, 25, 'father_name', 'Ravindra nath'),
(10, 25, 'father_mobile', '1234567890'),
(11, 25, 'mother_name', 'Savitri devi'),
(12, 25, 'mother_mobile', '0987654321'),
(13, 25, 'parents_address', 'Robertsganj, Sonebhadra'),
(14, 25, 'parents_country', 'India'),
(15, 25, 'parents_state', 'UP'),
(16, 25, 'parents_zip', '231216'),
(17, 25, 'school_name', 'MCLKP'),
(18, 25, 'previous_class', '1'),
(19, 25, 'status', 'Passed'),
(20, 25, 'total_marks', '500'),
(21, 25, 'obtain_mark', '445'),
(22, 25, 'previous_percentage', '89'),
(23, 25, 'section', '3'),
(24, 25, 'subject_streem', 'PCM'),
(25, 25, 'doa', '2023-10-17'),
(26, 26, 'children', 'a:2:{i:0;i:25;i:1;i:31;}'),
(27, 27, 'dob', '1112-09-12'),
(28, 27, 'mobile', '1234456727'),
(29, 27, 'payment_method', 'online'),
(30, 27, 'class', '1'),
(31, 27, 'address', 'asdf'),
(32, 27, 'country', 'asdf'),
(33, 27, 'state', 'asdf'),
(34, 27, 'zip', 'asdf'),
(35, 27, 'father_name', 'ABCD'),
(36, 27, 'father_mobile', '1234567890'),
(37, 27, 'mother_name', 'asdfasdf'),
(38, 27, 'mother_mobile', '1234567891'),
(39, 27, 'parents_address', 'asdfasdf'),
(40, 27, 'parents_country', 'asdfasdf'),
(41, 27, 'parents_state', 'asdfasdf'),
(42, 27, 'parents_zip', 'asdfasdf'),
(43, 27, 'school_name', 'asdfadsf'),
(44, 27, 'previous_class', '1'),
(45, 27, 'status', 'Failed'),
(46, 27, 'total_marks', '500'),
(47, 27, 'obtain_mark', '100'),
(48, 27, 'previous_percentage', '12'),
(49, 27, 'section', ''),
(50, 27, 'subject_streem', 'sdfs'),
(51, 27, 'doa', '2023-10-17'),
(52, 28, 'dob', '1112-09-12'),
(53, 28, 'mobile', '1234456727'),
(54, 28, 'payment_method', 'online'),
(55, 28, 'class', '1'),
(56, 28, 'address', 'asdf'),
(57, 28, 'country', 'asdf'),
(58, 28, 'state', 'asdf'),
(59, 28, 'zip', 'asdf'),
(60, 28, 'father_name', 'ABCD'),
(61, 28, 'father_mobile', '1234567890'),
(62, 28, 'mother_name', 'asdfasdf'),
(63, 28, 'mother_mobile', '1234567891'),
(64, 28, 'parents_address', 'asdfasdf'),
(65, 28, 'parents_country', 'asdfasdf'),
(66, 28, 'parents_state', 'asdfasdf'),
(67, 28, 'parents_zip', 'asdfasdf'),
(68, 28, 'school_name', 'asdfadsf'),
(69, 28, 'previous_class', '1'),
(70, 28, 'status', 'Failed'),
(71, 28, 'total_marks', '500'),
(72, 28, 'obtain_mark', '100'),
(73, 28, 'previous_percentage', '12'),
(74, 28, 'section', ''),
(75, 28, 'subject_streem', 'sdfs'),
(76, 28, 'doa', '2023-10-17'),
(77, 29, 'dob', '1112-09-12'),
(78, 29, 'mobile', '1234456727'),
(79, 29, 'payment_method', 'online'),
(80, 29, 'class', '1'),
(81, 29, 'address', 'asdf'),
(82, 29, 'country', 'asdf'),
(83, 29, 'state', 'asdf'),
(84, 29, 'zip', 'asdf'),
(85, 29, 'father_name', 'ABCD'),
(86, 29, 'father_mobile', '1234567890'),
(87, 29, 'mother_name', 'asdfasdf'),
(88, 29, 'mother_mobile', '1234567891'),
(89, 29, 'parents_address', 'asdfasdf'),
(90, 29, 'parents_country', 'asdfasdf'),
(91, 29, 'parents_state', 'asdfasdf'),
(92, 29, 'parents_zip', 'asdfasdf'),
(93, 29, 'school_name', 'asdfadsf'),
(94, 29, 'previous_class', '1'),
(95, 29, 'status', 'Failed'),
(96, 29, 'total_marks', '500'),
(97, 29, 'obtain_mark', '100'),
(98, 29, 'previous_percentage', '12'),
(99, 29, 'section', ''),
(100, 29, 'subject_streem', 'sdfs'),
(101, 29, 'doa', '2023-10-17'),
(102, 30, 'dob', '1112-09-12'),
(103, 30, 'mobile', '1234456727'),
(104, 30, 'payment_method', 'online'),
(105, 30, 'class', '1'),
(106, 30, 'address', 'asdf'),
(107, 30, 'country', 'asdf'),
(108, 30, 'state', 'asdf'),
(109, 30, 'zip', 'asdf'),
(110, 30, 'father_name', 'ABCD'),
(111, 30, 'father_mobile', '1234567890'),
(112, 30, 'mother_name', 'asdfasdf'),
(113, 30, 'mother_mobile', '1234567891'),
(114, 30, 'parents_address', 'asdfasdf'),
(115, 30, 'parents_country', 'asdfasdf'),
(116, 30, 'parents_state', 'asdfasdf'),
(117, 30, 'parents_zip', 'asdfasdf'),
(118, 30, 'school_name', 'asdfadsf'),
(119, 30, 'previous_class', '1'),
(120, 30, 'status', 'Failed'),
(121, 30, 'total_marks', '500'),
(122, 30, 'obtain_mark', '100'),
(123, 30, 'previous_percentage', '12'),
(124, 30, 'section', ''),
(125, 30, 'subject_streem', 'sdfs'),
(126, 30, 'doa', '2023-10-17'),
(127, 31, 'dob', '1112-09-12'),
(128, 31, 'mobile', '1234456727'),
(129, 31, 'payment_method', 'online'),
(130, 31, 'class', '1'),
(131, 31, 'address', 'asdf'),
(132, 31, 'country', 'asdf'),
(133, 31, 'state', 'asdf'),
(134, 31, 'zip', 'asdf'),
(135, 31, 'father_name', 'ABCD'),
(136, 31, 'father_mobile', '1234567890'),
(137, 31, 'mother_name', 'asdfasdf'),
(138, 31, 'mother_mobile', '1234567891'),
(139, 31, 'parents_address', 'asdfasdf'),
(140, 31, 'parents_country', 'asdfasdf'),
(141, 31, 'parents_state', 'asdfasdf'),
(142, 31, 'parents_zip', 'asdfasdf'),
(143, 31, 'school_name', 'asdfadsf'),
(144, 31, 'previous_class', '1'),
(145, 31, 'status', 'Failed'),
(146, 31, 'total_marks', '500'),
(147, 31, 'obtain_mark', '100'),
(148, 31, 'previous_percentage', '12'),
(149, 31, 'section', ''),
(150, 31, 'subject_streem', 'sdfs'),
(151, 31, 'doa', '2023-10-17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `fk_course` (`course_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `campus_functions`
--
ALTER TABLE `campus_functions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `communication`
--
ALTER TABLE `communication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `fk_parent_id` (`parent_id`),
  ADD KEY `fk_course_id` (`course_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_class_id` (`class_id`),
  ADD KEY `fk_teacher` (`teacher_id`);

--
-- Indexes for table `metadata`
--
ALTER TABLE `metadata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `child_id` (`child_id`);

--
-- Indexes for table `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_class` (`class_id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentanswers`
--
ALTER TABLE `studentanswers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `teacher_classes`
--
ALTER TABLE `teacher_classes`
  ADD PRIMARY KEY (`teacher_id`,`class_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `usermeta`
--
ALTER TABLE `usermeta`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `campus_functions`
--
ALTER TABLE `campus_functions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `communication`
--
ALTER TABLE `communication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `metadata`
--
ALTER TABLE `metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=233;

--
-- AUTO_INCREMENT for table `parents`
--
ALTER TABLE `parents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `periods`
--
ALTER TABLE `periods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `studentanswers`
--
ALTER TABLE `studentanswers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `timetable`
--
ALTER TABLE `timetable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usermeta`
--
ALTER TABLE `usermeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `assignments_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `assignments_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `fk_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `communication`
--
ALTER TABLE `communication`
  ADD CONSTRAINT `communication_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `communication_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_class_id` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `parents`
--
ALTER TABLE `parents`
  ADD CONSTRAINT `parents_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `periods`
--
ALTER TABLE `periods`
  ADD CONSTRAINT `periods_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- Constraints for table `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `results_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `studentanswers`
--
ALTER TABLE `studentanswers`
  ADD CONSTRAINT `studentanswers_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`),
  ADD CONSTRAINT `studentanswers_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `teacher_classes`
--
ALTER TABLE `teacher_classes`
  ADD CONSTRAINT `teacher_classes_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `teacher_classes_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `timetable`
--
ALTER TABLE `timetable`
  ADD CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
