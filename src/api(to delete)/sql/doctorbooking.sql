-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 20, 2020 at 06:38 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doctorbooking`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `bookingID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `planID` int(11) NOT NULL,
  `bookingTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`bookingID`),
  KEY `userID` (`userID`),
  KEY `planID` (`planID`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`bookingID`, `userID`, `planID`, `bookingTime`) VALUES
(1, 1, 1, '2020-09-02 11:57:37'),
(2, 2, 2, '2020-09-10 04:31:41'),
(3, 1, 3, '2020-09-21 03:33:58'),
(132, 1, 5, '2020-10-20 05:22:02');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
CREATE TABLE IF NOT EXISTS `doctor` (
  `doctorID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(200) NOT NULL,
  `lastName` varchar(200) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `email` varchar(200) NOT NULL,
  `contactNumber` varchar(50) NOT NULL,
  `picUrl` varchar(50) DEFAULT NULL,
  `Intro` varchar(1024) NOT NULL,
  `medicalCenter` varchar(50) NOT NULL,
  `areaOfSpec` varchar(255) NOT NULL,
  PRIMARY KEY (`doctorID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`doctorID`, `firstName`, `lastName`, `dateOfBirth`, `email`, `contactNumber`, `picUrl`, `Intro`, `medicalCenter`, `areaOfSpec`) VALUES
(1, 'Sareh', 'Ghaed ', '1980-02-02', 'doctor1@gmail.com', '1234563789', 'img/doctor1', 'Dr Sareh Ghaed Dr Sareh Ghaed is fellow of Royal Australian College of general Practitioners. She was graduated from medical school in 2007 and started her training in general practice since then. She is interested in all aspect of ', 'Chapel Hill Family Doctors', 'Chronic Disease Management'),
(2, 'Robyn', 'Mawer', '1960-03-01', 'doctor2@gmail.com', '1234567891', 'img/doctor1', 'Dr Robyn Mawer worked in Gladstone for over 30 years in General Practice.', 'My Medical & Dental', 'Skin Cancer Screening and Treatment'),
(4, 'Lai', 'Lowe', '2000-09-08', 'Lai@gmail.com', '1234567890', 'img/doctor1', 'She graduated from the University of Queensland', 'Family Doctor Plus', 'Internal Medicine');

-- --------------------------------------------------------

--
-- Table structure for table `logging`
--

DROP TABLE IF EXISTS `logging`;
CREATE TABLE IF NOT EXISTS `logging` (
  `logID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `action` varchar(255) NOT NULL DEFAULT 'test',
  `ip` varchar(10) NOT NULL,
  `browser` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`logID`),
  KEY `userID` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=3728 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logging`
--

INSERT INTO `logging` (`logID`, `userID`, `action`, `ip`, `browser`, `time`) VALUES
(3501, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:36:47'),
(3502, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:38:59'),
(3503, 1, 'booking', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:04'),
(3504, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:27'),
(3505, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:33'),
(3506, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:34'),
(3507, 1, 'addRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:42'),
(3508, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:43'),
(3509, 1, 'readRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:44'),
(3510, 1, 'updateRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:47'),
(3511, 1, 'delRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:48'),
(3512, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:49'),
(3513, 1, 'delRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:51'),
(3514, 1, 'delRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:39:56'),
(3515, 1, 'delRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-18 23:40:00'),
(3516, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:20:30'),
(3517, 1, 'booking', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:20:35'),
(3518, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:20:39'),
(3519, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:20:42'),
(3520, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:20:43'),
(3521, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:22:24'),
(3522, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:23:01'),
(3523, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:27:51'),
(3524, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:27:56'),
(3525, 1, 'readRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:28:08'),
(3526, 1, 'booking', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:34:06'),
(3527, 1, 'booking', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:34:09'),
(3528, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:34:28'),
(3529, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:34:31'),
(3530, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:34:32'),
(3531, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:39:23'),
(3532, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:39:56'),
(3533, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:39:59'),
(3534, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:40:00'),
(3535, 1, 'login', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:40:47'),
(3536, 1, 'booking', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:40:53'),
(3537, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:40:56'),
(3538, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:05'),
(3539, 1, 'booking', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:16'),
(3540, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:19'),
(3541, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:22'),
(3542, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:23'),
(3543, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:30'),
(3544, 1, 'addRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:34'),
(3545, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:35'),
(3546, 1, 'readRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:36'),
(3547, 1, 'updateRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:39'),
(3548, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:40'),
(3549, 1, 'delRating', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:43'),
(3550, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', '2020-10-19 00:41:44'),
(3551, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 01:12:38'),
(3552, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 01:12:40'),
(3553, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:32:47'),
(3554, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:32:54'),
(3555, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:33:01'),
(3556, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:33:05'),
(3557, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:33:08'),
(3558, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:33:09'),
(3559, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:51:27'),
(3560, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:51:44'),
(3561, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:51:48'),
(3562, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:51:50'),
(3563, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:51:55'),
(3564, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:51:57'),
(3565, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:51:58'),
(3566, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:01'),
(3567, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:02'),
(3568, 1, 'addRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:06'),
(3569, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:07'),
(3570, 1, 'addRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:09'),
(3571, 1, 'readRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:13'),
(3572, 1, 'updateRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:15'),
(3573, 1, 'updateRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:16'),
(3574, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:17'),
(3575, 1, 'delRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:18'),
(3576, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:19'),
(3577, 1, 'delRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:20'),
(3578, 1, 'delRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:22'),
(3579, 1, 'delRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:23'),
(3580, 1, 'delRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 12:52:25'),
(3581, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:05:30'),
(3582, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:08:41'),
(3583, 1, 'addRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:08:46'),
(3584, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:08:47'),
(3585, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:26:42'),
(3586, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:46:48'),
(3587, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:48:02'),
(3588, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:49:49'),
(3589, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:50:29'),
(3590, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:52:50'),
(3591, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:54:01'),
(3592, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:54:31'),
(3593, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:55:01'),
(3594, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:55:22'),
(3595, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:55:39'),
(3596, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:55:50'),
(3597, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:56:25'),
(3598, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:56:31'),
(3599, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:56:55'),
(3600, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:57:14'),
(3601, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:57:34'),
(3602, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:58:06'),
(3603, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:58:29'),
(3604, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:59:00'),
(3605, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:59:13'),
(3606, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 14:59:31'),
(3607, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 15:00:22'),
(3608, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 15:01:45'),
(3609, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 15:01:58'),
(3610, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 15:02:19'),
(3611, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-19 15:22:28'),
(3612, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:49:12'),
(3613, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:50:14'),
(3614, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:50:37'),
(3615, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:50:58'),
(3616, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:51:02'),
(3617, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:51:03'),
(3618, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:52:13'),
(3619, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:52:55'),
(3620, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:55:24'),
(3621, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:56:32'),
(3622, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:56:35'),
(3623, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 02:56:36'),
(3624, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:08:46'),
(3625, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:11:26'),
(3626, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:11:30'),
(3627, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:27:35'),
(3628, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:27:38'),
(3629, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:42:08'),
(3630, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:42:32'),
(3631, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:42:36'),
(3632, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:42:37'),
(3633, 1, 'readRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:42:42'),
(3634, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:42:51'),
(3635, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:42:54'),
(3636, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:45:24'),
(3637, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 03:45:26'),
(3638, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:12:36'),
(3639, 1, 'readRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:12:41'),
(3640, 1, 'updateRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:12:43'),
(3641, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:12:44'),
(3642, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:18:19'),
(3643, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:18:21'),
(3644, 1, 'readRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:18:23'),
(3645, 1, 'updateRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:18:25'),
(3646, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:18:26'),
(3647, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:21:20'),
(3648, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:21:22'),
(3649, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 04:21:23'),
(3650, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:10:55'),
(3651, 1, 'readRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:10:57'),
(3652, 1, 'updateRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:10:59'),
(3653, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:11:00'),
(3654, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:11:12'),
(3655, 1, 'readRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:11:14'),
(3656, 1, 'updateRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:11:17'),
(3657, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:11:18'),
(3658, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:21:37'),
(3659, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:22:02'),
(3660, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:22:10'),
(3661, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:23:17'),
(3662, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:23:23'),
(3663, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:24:57'),
(3664, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:00'),
(3665, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:03'),
(3666, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:04'),
(3667, 1, 'readRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:05'),
(3668, 1, 'updateRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:09'),
(3669, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:10'),
(3670, 1, 'delRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:11'),
(3671, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:12'),
(3672, 1, 'delRating', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:25:13'),
(3673, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:26:45'),
(3674, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:26:56'),
(3675, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:27:59'),
(3676, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:20'),
(3677, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:28'),
(3678, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:39'),
(3679, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:41'),
(3680, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:42'),
(3681, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:46'),
(3682, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:47'),
(3683, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:53'),
(3684, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:28:54'),
(3685, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:29:01'),
(3686, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:31:17'),
(3687, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:37:46'),
(3688, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:37:57'),
(3689, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:38:04'),
(3690, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:38:06'),
(3691, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:38:07'),
(3692, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:38:10'),
(3693, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 05:38:11'),
(3694, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:00:14'),
(3695, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:03:46'),
(3696, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:03:53'),
(3697, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:03:58'),
(3698, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:01'),
(3699, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:02'),
(3700, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:09'),
(3701, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:11'),
(3702, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:14'),
(3703, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:19'),
(3704, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:22'),
(3705, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:23'),
(3706, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:26'),
(3707, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:04:27'),
(3708, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:06:14'),
(3709, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:06:16'),
(3710, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:08:23'),
(3711, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:11:55'),
(3712, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:12:35'),
(3713, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:13:25'),
(3714, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:15:04'),
(3715, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:16:17'),
(3716, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:17:40'),
(3717, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:17:42'),
(3718, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:19:37'),
(3719, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:21:06'),
(3720, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:21:43'),
(3721, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:24:30'),
(3722, 1, 'booking', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:24:37'),
(3723, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:24:43'),
(3724, 1, 'cancelAppt', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:24:46'),
(3725, 1, 'showAppHistory', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:24:47'),
(3726, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:26:25'),
(3727, 1, 'login', '::1', 'Mozilla/5.0 (Linux; Android 6.0.1; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Mobile Safari/537.36', '2020-10-20 06:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
CREATE TABLE IF NOT EXISTS `plan` (
  `planID` int(11) NOT NULL AUTO_INCREMENT,
  `doctorID` int(11) NOT NULL,
  `planDate` date NOT NULL,
  `planTimeStart` varchar(16) NOT NULL,
  `planTimeEnd` varchar(16) NOT NULL,
  PRIMARY KEY (`planID`),
  KEY `doctorID` (`doctorID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plan`
--

INSERT INTO `plan` (`planID`, `doctorID`, `planDate`, `planTimeStart`, `planTimeEnd`) VALUES
(1, 1, '2020-09-30', '10:00', '10:15'),
(2, 1, '2020-09-30', '10:15', '10:30'),
(3, 2, '2020-10-10', '10:30', '10:45'),
(5, 4, '2020-10-25', '16:15', '16:30'),
(6, 2, '2020-10-29', '14:15', '14:30'),
(7, 1, '2020-10-30', '10:15', '10:30'),
(8, 1, '2020-10-28', '11:15', '11:30');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
CREATE TABLE IF NOT EXISTS `rating` (
  `ratingID` int(11) NOT NULL AUTO_INCREMENT,
  `bookingID` int(11) NOT NULL DEFAULT 2,
  `scale` int(11) NOT NULL,
  `content` text NOT NULL,
  `ratingTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ratingID`),
  KEY `bookingID` (`bookingID`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`ratingID`, `bookingID`, `scale`, `content`, `ratingTime`) VALUES
(1, 1, 2, 'good !!!!', '2020-09-02 12:11:30'),
(2, 2, 4, 'good good ~!!!!!', '2020-09-10 10:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(30) NOT NULL,
  `passWord` varchar(255) NOT NULL,
  `firstName` varchar(200) NOT NULL,
  `lastName` varchar(200) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `email` varchar(200) NOT NULL,
  `contactNumber` varchar(50) NOT NULL,
  `privilege` varchar(50) NOT NULL DEFAULT '1',
  `address` varchar(255) NOT NULL,
  `suburb` varchar(255) NOT NULL,
  `state` varchar(50) NOT NULL,
  `postcode` int(10) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `userName`, `passWord`, `firstName`, `lastName`, `dateOfBirth`, `email`, `contactNumber`, `privilege`, `address`, `suburb`, `state`, `postcode`) VALUES
(1, 'test', '$2y$10$9Moc6kEcNsoeDmont5vDf.GZ9m6YanTiGuDCRsdds.mj0ylLR8UbW', 'Claire', 'Wang', '2000-01-01', 'test@gmail.com', '1234567890', '1', '', '', '', 0),
(2, 'test1', '$2y$10$9Moc6kEcNsoeDmont5vDf.GZ9m6YanTiGuDCRsdds.mj0ylLR8UbW', 'Evan', 'MA', '2000-03-01', 'test1@gmail.com', '1234567891', '1', '', '', '', 0),
(3, 'test2', 'Test123456', 'Evan', 'Wang', '2000-03-01', 'test1@gmail.com', '1234567891', '1', '', '', '', 0),
(27, 'fdafd12', 'Test123456', 'dd', 'fdw', '2020-09-02', 'claire110226@gmail.com', '4132414124', '1', '', '', '', 0),
(28, 'test6', 'Test123456', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '', '', '', 0),
(31, 'qwe34', 'Test123', 'ddd', 'fff', '2020-09-01', 'claire110@gmail.com', '1234567896', '1', '', '', '', 0),
(32, 'dsaf333e2', 'Test123456', 'fdsf', 'fdafff', '2020-08-11', 'ddfds@gmail.com', '1234567891', '1', '', '', '', 0),
(33, 'test1121', 'da', 'dff', 'da', '2020-09-01', 'dsfa@vdsaf.com', '4132414124', '1', '', '', '', 0),
(36, 'fsdaf', 'fdafsa', 'dfd', 'fdfd', '2020-09-03', 'dfd', '324141324', '1', '', '', '', 0),
(41, 'fdsfs', 'Yhong110', 'fdsf', 'fdfd', '2020-09-01', 'fdsfsd@gmail.com', '4132414124', '1', '', '', '', 0),
(42, 'dfd', 'Yhong110', 'dd', 'dsd', '2020-09-01', 'claire110226@gmail.com', '3423424233', '1', '', '', '', 0),
(43, 'fgg', 'Yhong110', 'dfd', 'fff', '2020-09-02', 'claire110226@gmail.com', '4132414124', '1', '', '', '', 0),
(46, 'ccc', 'Yhong110', 'ddd', 'ddd', '2020-09-02', 'claire110226@gmail.com', '4132414124', '1', '', '', '', 0),
(51, 'cdsf', 'Yhong110', 'df', 'dd', '2020-09-01', 'claire110226@gmail.com', '3241312344', '1', '', '', '', 0),
(59, 'testaddress4', 'Test123456', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(60, 'address', 'Test1234', 'flas', 'fdsa', '2020-09-03', 'claire110226@gmail.com', '1234567891', '1', '11 Ffloyd Court', 'YAMBA', 'NSW', 2464),
(68, 'dfsf', 'Test12345', 'fdas', 'ffff', '2020-09-01', 'ewrew@gmail.com', '3241312344', '1', 'Unit 1205, 12-14 Executive Drive', 'BURLEIGH WATERS', 'QLD', 4220),
(69, 'ewrewtest', 'Test1234', 'dsf', 'fff', '2020-09-03', 'claire110226@gmail.com', '1234567891', '1', 'Unit 1205, 12-14 Executive Drive', 'BURLEIGH WATERS', 'QLD', 4220),
(70, 'testtest', 'Test12345', 'Claire', 'ddd', '2020-09-01', 'cfdsfdfdsfsdfdsfsd@gmailc.om', '1234567895', '1', 'Unit 1205, 12-14 Executive Drive', 'BURLEIGH WATERS', 'QLD', 4220),
(71, 'testa', 'Test12345', 'tes', 'Wang', '2020-09-09', 'ddfds@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(72, 'DSF', 'dd', 'dd', 'ddd', '2020-09-02', 'ddfds@gmail.com', '1234567891', '1', '17-23 George Road', 'SALAMANDER BAY', 'NSW', 2317),
(73, 'cdsfad', 'dsafa', 'gfdg', 'gfgg', '2020-09-03', 'fdsfsd@gmail.com', '3432453253', '1', '44-46 Burrowes Street', 'SURAT', 'QLD', 4417),
(86, 'df2322fdpost2', 'Test123456', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(87, 'df2322fdpost24', 'erw', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(88, 'df2322fdpost2443', 'Test1242er', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(89, 'df23223post', 'Test1242345', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(90, 'df23223postd', 'Test1242345', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(91, 'df23223postd1', 'Test1242345', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(92, 'df23223postd12', 'Test1242345', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(93, 'df23223postd12332', 'fdafsa', 'dew', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(101, 'df23223postd12332d1', 'dds', 'd', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(102, 'df2322', 'Test123456', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(103, 'df23223postd12332d0', 'dds', 'd', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(104, 'te', 'Test123456', 'wer', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(105, 'ted', 'Test123456', 'wer', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(106, 'ter', 'Test123456', 'wer', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(107, '128', 'Test123456', 'wer', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(108, '128v', 'Test123456', 'we', 'We', '2000-03-01', 'test3@gmail.com', '1234567890', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 12),
(109, 'fds', 'Yhong110', 'dd', 'ff', '2020-09-02', 'cdsf@gmail.com', '3242432421', '1', '34 Railway Street', 'GOROKE', 'VIC', 3412),
(110, 'hash', '$2y$10$9Moc6kEcNsoeDmont5vDf.GZ9m6YanTiGuDCRsdds.mj0ylLR8UbW', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(111, 'admin', '$2y$10$b.EhbuD8MDT.jU/IjxOhDO15cDCgZ5oZiZAz/jeKOpI9T1soxRXpu', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '2', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(112, 'pro2', '$2y$10$4c5cwDHrn9HDoUx5t4uWp.TIZU/kvRXDF2iJaKs5xZ3CiaCurFkI6', 'pro', 'Wang', '2020-09-01', 'test3@gmail.com', '1234567891', '1', '120 Falls Road', 'WENTWORTH FALLS', 'NSW', 2782),
(113, 'df23221', '$2y$10$S.CRrNbOFMx64D6mAsU5wuD9hgainGMmwFvLokCv1ocBvwLfXzUIO', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(114, 'pro1', '$2y$10$hYBYyoRMpxtAhFFzjDLq3OOrjjpMtouFkyd5za44aoGSxlQg7hgtS', 'fdas', 'EW', '2020-09-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(115, 'pro3', '$2y$10$foxsBpyX2dYeQ.g.VvrljOFFE8X4y7FG8FA0MYnLWdnHhYhBfVG9m', 'fsda', 'fd', '2020-09-02', 'test3@gmail.com', '1234567891', '1', '895 Princes Freeway', 'LARA', 'VIC', 3212),
(116, 'df232221', '$2y$10$YvM5DNz/frLflT3ifn/oEO4fyewpDaaemxGDpEVQU86vtGXIzW5j.', 'Evan', 'Wa', '2000-03-01', 'test3@gmail.com', '1234567891', '1', '26-34 Roy Street', 'JEPARIT', 'VIC', 3423),
(117, 'pro4', '$2y$10$sYPsP3G4TPAuZU8ic5MVuuU4jrRBog5yZZlrNnzs7XB8vb9kOB3dW', 'ds', 'fds', '2020-09-09', 'test3@gmail.com', '1234567891', '1', '17-23 George Road', 'SALAMANDER BAY', 'NSW', 2317),
(118, 'pro5', '$2y$10$65LNiRIdG6aiJMfWgU4qS.qSZcOO7MqNR1MzJum1S7gKfbTsca9Nm', 'fdsa', 'fd', '2020-09-09', 'test3@gmail.com', '1234567895', '1', 'Unit 1205, 12-14 Executive Drive', 'BURLEIGH WATERS', 'QLD', 4220),
(119, 'pro6', '$2y$10$IOe6XbtGB21TvzCPJ42dJuBXI/zPRdKCAsV55U9Zl5beJsmrhjRcS', 'ds', 'ffff', '2020-09-01', 'cdsf@gmail.com', '1234567891', '1', '19-23 Donald Street', 'NELSON BAY', 'NSW', 2315),
(120, 'pro7', '$2y$10$V6YsJEIVpwIaDNfc9UnC..jlOjFXt4EM3e263sXWC09kWZTAugt6q', 'we', 'ee', '2020-09-07', 'test3@gmail.com', '1234567891', '1', '21-23 Tomaree Street', 'NELSON BAY', 'NSW', 2315),
(121, 'fdafd121', '$2y$10$0AfnAQ1bPoXgsODy2CrfS.i.DJgIXr15F8z0nn0ZXFn.hnvyzwWce', 'we', 'wq', '2000-03-01', 'ewrew@gmail.com', '1234567895', '1', '2308 Wealwandangie Road', 'WEALWANDANGIE', 'QLD', 4722),
(122, 'dfdf', '$2y$10$x48BgPHhc/0rP/OUbjkrcuJ1CPFBu9ovn15SeOQnFLbcmkr5LVr4u', 'te', 'te', '2020-10-08', 'claire110226@gmail.com', '3423424233', '1', '828 Ercildoun Road', 'ERCILDOUNE', 'VIC', 3352),
(123, 'tee', '$2y$10$H6ViEiA9pz/Z2763ZSzpd.W0Gy5/Ngqw3K5OqhUoX1xwtHBWC0RUu', 'sd', 'fds', '2020-10-08', 'cfdsfdfdsfsdfdsfsd@gmailc.om', '3432453253', '1', '23-31 Brocklesby Road', 'MEDOWIE', 'NSW', 2318),
(124, 'tes', '$2y$10$3QHU/0EenCkqwc1Pms3/MeSiR3ljSpRJ5MfqceexWJFhCk8pNiDfq', 'fdsa', 'fdsa', '2020-10-01', 'ddfds@gmail.com', '1234567891', '1', 'Suite 1202, Level 12, 8-12 Castlereagh Street', 'SYDNEY', 'NSW', 2000),
(125, 'dfa', '$2y$10$d9P.mpdGpGD11thQwHwLH.KPdmz4JU2SbGcGLRo9rpIPat9Qx37NS', 'df', 'fdsa', '2020-10-03', 'cfdsfdfdsfsdfdsfsd@gmailc.om', '1234567891', '1', 'Suite 1202, Level 12, 8-12 Castlereagh Street', 'SYDNEY', 'NSW', 2000);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`planID`) REFERENCES `plan` (`planID`);

--
-- Constraints for table `logging`
--
ALTER TABLE `logging`
  ADD CONSTRAINT `logging_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`);

--
-- Constraints for table `plan`
--
ALTER TABLE `plan`
  ADD CONSTRAINT `plan_ibfk_1` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`doctorID`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`bookingID`) REFERENCES `booking` (`bookingID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
