-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2021 at 06:05 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kk`
--

-- --------------------------------------------------------

--
-- Table structure for table `building`
--

CREATE TABLE `building` (
  `id` int(11) NOT NULL,
  `building_name` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `building`
--

INSERT INTO `building` (`id`, `building_name`) VALUES
(11, 'อาคาร 1 ชั้น 1 ลานเวที'),
(12, 'อาคาร 1 ชั้น 2M องค์การนักศึกษา '),
(13, '232 ห้องปฏิบัติการอาหาร'),
(14, '233 ห้องพักอาจรย์'),
(15, '234 ห้องพักอาจรย์'),
(16, '235 ห้องพักอาจรย์'),
(17, '241 ห้องบรรยายสาขาวิชาคหกรรมศาสตร์'),
(18, '242 ห้องปฏิบัติการด้านดอกไม้'),
(19, '243 ห้องพักอาจารย์'),
(20, '244 ห้องพักอาจารย์'),
(21, '245 ห้องพักอาจารย์'),
(22, '251 ห้องบรรยาย'),
(23, '252 ห้องพักอาจารย์'),
(24, '261 ห้องบรรยาย 1'),
(25, '262 ห้องบรรยาย 2'),
(26, '271 ห้องบรรยาย 1'),
(27, '272 ห้องบรรยาย 2'),
(28, '273 ห้องบรรยาย 3'),
(29, '281 ห้องบรรยาย 1'),
(30, '282 ห้องบรรยาย 2'),
(31, '283 ห้องบรรยาย 3'),
(32, '291 ห้องบรรยาย 1'),
(33, '292 ห้องบรรยาย 2'),
(34, '293 ห้องบรรยาย 3'),
(35, '2101 ห้องบรรยาย 1'),
(36, '2102 ห้องบรรยาย 2'),
(37, '2103 ห้องบรรยาย 3'),
(38, '2111 Bermuda Operation Room'),
(39, '2112 Pandora Animation Lab'),
(40, '2113 Asgard Animation Lab'),
(41, '2114 Andromeda Animation Lab'),
(42, '2115 Atlantis Sound Lab'),
(43, '2121 Arale Lab'),
(44, '2122 Mario Sound Lab'),
(45, '2123 Totoro Sound Lab'),
(46, '2124 Stitch Lab'),
(47, '2125 Nobita Lab'),
(48, '2126 Sollliva Lab'),
(49, 'อาคาร 3 ชั้นที่ 1 DSS CENTER ศูนย์สนับสนุนนักศึกษาพิการ'),
(50, 'อาคาร 3 ชั้นที่ 1 ศูนย์หนังสือศรีสมเด็จ BSRU'),
(51, 'อาคาร 3 ชั้นที่ 1 ร้านค้าชงโคมาร์ท'),
(52, 'อาคาร 3 ชั้นที่ 2 สาขาคอมพิวเตอร์ศึกษา'),
(53, 'อาคาร 3 ชั้นที่ 2 สาขาวิชาสังคมศึกษา'),
(54, '1131 สำนักวิเทศสัมพันธ์และเครือข่ายอาเซียน'),
(55, '443 ห้องเรียนสันทนาการ'),
(56, 'อาคาร 12 ชั้น 2 สาขาวิชาศิปกรรมศึกษา'),
(57, '411 ห้องปฏิบัติการ'),
(58, '412 ห้องภาควิชาวิทยาการคอมพิวเตอร์'),
(59, '413 ห้องพักอาจารย์'),
(60, '422 ห้องพักอาจารย์'),
(61, '423 ห้องบรรยาย'),
(62, '424 ห้องบรรยาย'),
(63, '425 ห้องพักอาจารย์'),
(64, '431 ห้องปฏิบัติการ'),
(65, '432 ห้องบรรยาย'),
(66, '433 ห้องพักอาจรย์'),
(67, '434 ห้องพักอาจรย์'),
(68, '435 ห้องปฏิบัติการ'),
(69, '441 สาขาวิทยาศาสตร์สิ่งแวดล้อม'),
(70, '442A ห้องปฏิบัติการ'),
(71, '442B ห้องปฏิบัติการ'),
(72, '243 ห้องบรรยาย'),
(73, '444 ห้องบรรยาย'),
(74, '445 ห้องบรรยาย'),
(75, 'อาคาร 5 ชั้น 1 สำนักส่งเสริมวิชาการและงานทะเบียน'),
(76, 'อาคาร 5 ชั้น 2 สำนักส่งเสริมวิชาการและงานทะเบียน'),
(77, '521 ห้องปฏิบัติการเทคโนโลยีสารสนเทศ'),
(78, '541 ห้องปฏิบัติการเทคโนโลยีสารสนเทศ'),
(79, '542 ห้องปฏิบัติการเทคโนโลยีสารสนเทศ'),
(80, '543 ห้องปฏิบัติการเทคโนโลยีสารสนเทศ'),
(81, '544 ห้องปฏิบัติการเทคโนโลยีสารสนเทศ'),
(82, '545 ห้องปฏิบัติการเทคโนโลยีสารสนเทศ'),
(83, 'อาคาร 7 ชั้น 1 สำนักงานคณะวิทยาการจัดกาาร'),
(84, 'อาคาร 7 ชั้น 2 ฝ่ายยานพาหนะ'),
(85, 'อาคาร 7 ชั้น 3 ฝ่ายยานพาหนะ'),
(86, 'อาคาร 7 ชั้น 2 ที่จอดรถ'),
(87, 'อาคาร 7 ชั้น 3 ที่จอดรถ'),
(89, 'อาคาร 30 ชั้น 2 ที่จอดรถ'),
(90, 'อาคาร 30 ชั้น 3 ที่จอดรถ'),
(91, '300401 ห้องประชุม'),
(92, '300402 สาขาวิชาวิทยาศาสตร์ทั่วไป'),
(93, '300403 ห้องประชุม'),
(94, '300404 สาขาวิชาชีววิทยา'),
(95, '300405 สาขาวิชาฟิสิกข์'),
(96, '300406 สาขาวิชาเคมี'),
(97, '300407 ห้องควบคุมเครื่องแม่ข่าย'),
(98, '300409 สาขาวิชาศึกษาปฐมวัย'),
(99, '300410 ศูนย์ปฏิบัติการทางภาษา'),
(100, '300411 ศูนย์ปฏิบัติการคอมพิวเตอร์'),
(101, '300412 ศูนย์ปฏิบัติการไมโครทิชชิ่ง'),
(102, '300413 กลุ่มวิชาชีพ'),
(103, 'อาคาร 30 ชั้นที่ 4 ทางเชื่อมระหว่างอาคาร 29-30'),
(104, '300501 ห้องประชุม'),
(105, '300502 คลินิกแนะแนว'),
(106, '300503 สาขาวิชาจิตวิทยา'),
(107, '300504 ห้องปฏิบัติการจิตวิทยา'),
(108, '300505 ห้องปฏิบัติการนาฏยศิลป์ศึกษา 1'),
(109, '300506 สาขาวิชานาฏยศิลป์ศึกษา'),
(110, '300507 ห้องปฏิบัติการนาฏยศิลป์ศึกษา 2'),
(111, '500508 ห้องปฏิบัติการภาษาอังกฤษ'),
(112, '300509 สาขาวิชาภาษาอังกฤษ'),
(113, '300510 ห้องปฏิบัติการเทคโนโลยีและสื่อสารการศึกษา1'),
(114, '300513 ห้องปฏิบัติการเทคโนโลยีและสื่อสารการศึกษา2'),
(115, '300511 สาขาวิชาเทคโนโลยีและสื่อสาการศึกษา'),
(116, '300512 ห้องบรรยาย'),
(117, '300601 สาขาวิชาคณิตศาสตร์'),
(118, '300602 สาขาวิชาสังคมศึกษา'),
(119, '300603 ห้องปฏิบัติการคณิตศาสตร์'),
(120, '300604 ห้องปฏิบัติการสังคมศึกษา'),
(121, '300605 สาขาวิชาคอมพิวเตอร์ศึกษา 1'),
(122, '300606 สาขาวิชาคอมพิวเตอร์ศึกษา 2'),
(123, '300607 ห้องบรรยาย'),
(124, '300610 ห้องบรรยาย'),
(125, '300613 ห้องบรรยาย'),
(126, '300608 ห้องปฏิบัติการภาษาไทย'),
(127, '300609 สาขาวิชาภาษาไทย'),
(128, '300611 ห้องปฏิบัติการวิทยาศาสตร์'),
(129, '300612 สาขาวิชาการประเมินผลและวิจัยทางการศึกษา'),
(130, '300614 ห้องปฏิบัติการประเมินผลและวิจัยฯ'),
(131, '300701 ห้องสมุด เทวาประสิทธิ์'),
(132, '300702 ห้องปฏิบัติการคอมพิวเตอร์ศึกษา 1'),
(133, '300703 ห้องปฏิบัติการคอมพิวเตอร์ศึกษา 2'),
(134, '300705 ห้องปฏิบัติการคอมพิวเตอร์ศึกษา 3'),
(135, '300704 ศูนย์บริการสารสนเทศเพื่อการศึกษา'),
(136, '300801 ห้องบรรยาย'),
(137, '300802 ห้องบรรยาย'),
(138, '300803 ห้องบรรยาย'),
(139, '300804 ห้องบรรยาย'),
(140, '300806 ห้องบรรยาย'),
(141, '300805 สาขาวิชาบริหารการศึกษา'),
(142, '300901 ห้องบรรยาย'),
(143, '300902 ห้องบรรยาย'),
(144, '300903 ห้องบรรยาย'),
(145, '300904 ห้องบรรยาย'),
(146, '300905 ห้องบรรยาย'),
(147, '300906 ห้องบรรยาย'),
(148, '300907 ห้องบรรยาย'),
(149, '300908 ห้องบรรยาย'),
(150, '300909 ห้องบรรยาย'),
(151, '301001 ห้องประชุม'),
(152, '301002 ห้องบรรยาย'),
(153, '301003 ห้องบรรยาย'),
(154, '301005 ห้องบรรยาย'),
(155, '301004 สาขาวิชาพลศึกษา'),
(156, '301006 ห้องปฏิบัติการจิตวิทยา'),
(157, '301007 ห้องปฏิบัติการการศึกษาปฐมวัย'),
(158, '301008 ศุนย์ศึกษาการพัฒนาครู'),
(159, '301101 ห้องประชุม'),
(160, '301102 ห้องบรรยาย'),
(161, '301105 ห้องบรรยาย'),
(162, '301106 ห้องบรรยาย'),
(163, '301103 ห้องปฏิบัติการศิลปศึกษา'),
(164, '301104 สาขาศิลปศึกษา'),
(165, '301201 ห้องปฏิบัติการดนตรีไทย 1'),
(166, '301202 ห้องปฏิบัติการดนตรีไทย 2'),
(167, '301203 ห้องปฏิบัติการดนตรีไทย 3'),
(168, '301204 สาขาวิชาดนตรีศึกษา'),
(169, '301205 ห้องปฏิบัติการดนตรีตะวันตก 1'),
(170, '301206 ห้องปฏิบัติการดนตรีตะวันตก 2'),
(171, '301207 ห้องปฏิบัติการดนตรีตะวันตก 3'),
(172, '301208 ห้องซ้อมย่อย 1'),
(173, '301209 ห้องซ้อมย่อย 2'),
(174, '301210 ห้องซ้อมย่อย 3'),
(175, '301211 ห้องซ้อมย่อย 4'),
(176, '301212 ห้องซ้อมย่อย 5'),
(177, '301213 ห้องซ้อมย่อย 6'),
(178, '301214 ห้องซ้อมย่อย 7'),
(179, '301215 ห้องซ้อมย่อย 8'),
(180, '301216 ห้องปฏิบัติการดนตรีตะวันตก'),
(208, 'อาคาร 1 ชั้น 3 ห้องเกีรยติประวัติ บ้านสมเด็จ'),
(210, 'อาคาร 1 ชั้น 2M สำนักกิจการนิสิตนักศึกษา'),
(211, '221 ห้องพักอาจารย์'),
(212, '222 ห้องปฏิบัติการอาหารและเบเกอรี่'),
(213, '231 ห้องพักอาจารย์'),
(214, 'อาคาร 2 ชั้น 1 งานเทคโนโลยีทางการศึกษา'),
(215, 'อาคาร 1 ชั้น 2 ศูนย์อาหารบ้านสมเด็จเจ้าพระยา (BSRU Center)'),
(216, 'อาคาร 1 ชั้น 4 หอประชุมใหญ่'),
(218, '6121 ห้องปฏิบัติการสาขาวิทยาการคอมพิวเตอร์'),
(219, '645 ห้องเรียน 1');

-- --------------------------------------------------------

--
-- Table structure for table `floors`
--

CREATE TABLE `floors` (
  `id` int(11) NOT NULL,
  `floors_no` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `floors`
--

INSERT INTO `floors` (`id`, `floors_no`) VALUES
(1, 'ชั้น 1'),
(2, 'ชั้น 2');

-- --------------------------------------------------------

--
-- Table structure for table `house`
--

CREATE TABLE `house` (
  `build_id` int(11) NOT NULL,
  `build_kk` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `floorspp` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `numRoom` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `placeName` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `house`
--

INSERT INTO `house` (`build_id`, `build_kk`, `floorspp`, `numRoom`, `placeName`) VALUES
(3, '0', '5', '5', 'kolllllllllll'),
(5, '0', '0', '', ''),
(6, '0', '0', '', ''),
(7, '0', '3', '', ''),
(8, '0', '4', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE `maintenance` (
  `id_mtn` int(11) NOT NULL,
  `mtn_autoID` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL,
  `mtn_name` text COLLATE utf8_unicode_ci NOT NULL,
  `mtn_lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `mtn_phone` text COLLATE utf8_unicode_ci NOT NULL,
  `gender` text COLLATE utf8_unicode_ci NOT NULL,
  `token_mtn` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `maintenance`
--

INSERT INTO `maintenance` (`id_mtn`, `mtn_autoID`, `password`, `mtn_name`, `mtn_lastname`, `mtn_phone`, `gender`, `token_mtn`) VALUES
(1, '$autoID', '$passwordStr', '$nameStr', '$lastNameStr', '$phoneStr', '$_chosenValue', '$token'),
(2, '$autoID', '$passwordStr', '$nameStr', '$lastNameStr', '$phoneStr', '$_chosenValue', '$token'),
(3, 'MTN268.jpg', '่า', 'ยย', '้่', '789', 'ชาย', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(4, 'MTN557', 'ิ้', 'ดด', 'อิ', '688', 'ชาย', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(5, 'MTN657', '้85', 'ยบง', 'อาส', '6788', 'หญิง', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(9, 'mtn718', 'gj', 'kkg', 'fg', '856', 'หญิง', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(10, 'mtn147', 'วววววว', 'ววววววววว', 'วววววววว', '0888555', 'หญิง', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(11, '0', 'hhh', 'hhh', 'nnn', '555', 'หญิง', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(12, '0', 'vj', 'njk', 'h', '859', 'ชาย', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(13, 'mtn106', 'h', 'bj', 'bj', '582', 'ชาย', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh');

-- --------------------------------------------------------

--
-- Table structure for table `rate`
--

CREATE TABLE `rate` (
  `id` int(11) NOT NULL,
  `idWarning` int(11) NOT NULL,
  `rate` double NOT NULL,
  `comment_rec` text NOT NULL,
  `idBuildForm` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `buildForm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `build_kk` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `floors_pp` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `numRoom` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `moreForm` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rate`
--

INSERT INTO `rate` (`id`, `idWarning`, `rate`, `comment_rec`, `idBuildForm`, `buildForm`, `build_kk`, `floors_pp`, `numRoom`, `moreForm`) VALUES
(57, 65, 2.5, 'null', '35', '2101 ห้องบรรยาย 1', '', '', '', ''),
(60, 71, 5, 'สสสสส', '35', '2101 ห้องบรรยาย 1', '', '', '', ''),
(61, 72, 2.5, 'นสนรายต่ิ', '29', '281 ห้องบรรยาย 1', '', '', '', ''),
(62, 86, 1, 'kkk', '1', '', '1', '2', '3', 'null'),
(63, 86, 1, 'kkk', '1', '', '1', '2', '3', 'null');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `student_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `student_id`, `name`, `password`, `level`, `gender`, `position`, `token`) VALUES
(2, 'admin', 'admin', 'admin', 'admin', '', '', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(11, '6021207001', 'กชมล เชื้อวงศ์พรหม', '06042541', 'user', 'Female', '', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3'),
(12, '1234', 'วิวัฒน์', '1234', 'user', 'male', '', 'eRUxNEYXR1SfV2cZVzqBEp:APA91bE5XBIxzbcHnNeQXJB2puhcZTzjx1hm1vamQBPnlSIS2KrrnX0Meb9V5l0Y1JplPZhICncTQPeWUWVOKwM2zVmkNHCTQ9FyKhO-gi8V1Q_KZ_8sWBz9SOp6AS2vWGy3bE78zCzy'),
(14, '6021207062', 'ปรวี ทองน้อย', '123456', 'user', 'Female', '', 'cH76bu9mT4q3h0iRS5rxD_:APA91bHMAmXE-59wQ2H3_1HXcuHyBETmEu9i_4QffXELO3-lv-Uur2bK6j3_CszptRnnlNOMLUkKkFAb9taETaL5M88RAHvXZXETHkpKrQy1WM7USDZpuynp3hvsU4zTIcd0NoWKoh6K'),
(15, '60', 'วิวัฒน์', '1234', 'user', 'male', '', 'dcCEz5kGTQ6YQkjKHOfQs9:APA91bEmgKIIsp2w2Avm_Hi9JdvvTo62tYlMktHOB_7wlE6EaSFAVbX8bdmjTzAnWU8hy78UESlxK9GTyIaAn89CWTi9Bp8CJS6bKYXve0wNIo86ZeOYqH_nwn6SQHvPe1kPaSRTJbRy'),
(16, '6021207011', 'สวัสดี', '1234', 'user', 'Female', '', ''),
(17, '602579', 'ราตรี', '1234', 'user', 'male', '', 'eM0G3lx9QbGVj4eGP46Ixl:APA91bHraht778r8vUiMjH01OgCFaLoK5PUl8h1kL3UKdtHOJICk_jPCa4i3blY2ycgQPIVApCNGnEZyrnGOjxzx48R3iUTlDCyaDUufe1TU_W3EmWilI0ABXKRLP-AT3nlTt3R0nW3K'),
(18, '6012', 'ggg', '1234', 'user', 'male', '', ''),
(19, '6012', 'ggg', '1234', 'user', 'male', '55555', ''),
(20, '6021207005', 'อรุณี เผ่าทัพ', '1234', 'user', 'Female', 'student', 'eM0G3lx9QbGVj4eGP46Ixl:APA91bHraht778r8vUiMjH01OgCFaLoK5PUl8h1kL3UKdtHOJICk_jPCa4i3blY2ycgQPIVApCNGnEZyrnGOjxzx48R3iUTlDCyaDUufe1TU_W3EmWilI0ABXKRLP-AT3nlTt3R0nW3K'),
(21, '1234', 'ชัชชัย สน', '1234', 'user', 'male', 'officer', 'eRUxNEYXR1SfV2cZVzqBEp:APA91bE5XBIxzbcHnNeQXJB2puhcZTzjx1hm1vamQBPnlSIS2KrrnX0Meb9V5l0Y1JplPZhICncTQPeWUWVOKwM2zVmkNHCTQ9FyKhO-gi8V1Q_KZ_8sWBz9SOp6AS2vWGy3bE78zCzy'),
(22, 'มิวงใ', 'น่นวใ', '1234', 'user', 'male', 'สม่', ''),
(23, 'kjm', 'สสสส', '123', 'user', 'Female', 'teacher', ''),
(24, 'hhh', 'hhh', 'hhh', 'user', 'Female', 'teacher', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(25, 'kkk', 'kkk', 'kkk', 'user', 'Female', 'teacher', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh'),
(26, 'qqq', 'qqq', 'qqq', 'user', 'male', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(27, 'www', 'wwe', 'wwe', 'user', 'Female', 'more', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(28, 'rrr', 'rrr', 'rrr', 'user', 'male', 'jklm', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(29, 'ttt', 'ttt', 'ttt', 'user', 'male', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(30, 'yyy', 'yyy', 'yyy', 'user', 'male', 'student', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(31, 'uuu', 'uuu', 'uuu', 'user', 'male', 'สวน', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(32, 'aaa', 'aaa', 'aaa', 'user', 'Female', 'hk', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(33, 'ooo', 'kkk', 'ppp', 'user', 'Female', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(34, 'ggg', 'ggg', 'ggg', 'user', 'Female', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(35, 'hjhhhhh', '7890', '7890', 'user', 'Female', 'teacher', 'cnWi0wMJTPibXQw4enWgto:APA91bHGchnNGBxh4o4mGKCfRveMMeehIodmwan_lOqaJX4nYTPtG2-Q3HuCW-VLv9B8CcGh-zl7E-wwcbTHLQXm-hF1AlcdwnLNWzjW_91VS3l8AimGm__Qg_XNdgDwy-C7k0gUJKlE'),
(36, 'b', 'k', 'v', 'user', 'Female', 'k', 'cnWi0wMJTPibXQw4enWgto:APA91bHGchnNGBxh4o4mGKCfRveMMeehIodmwan_lOqaJX4nYTPtG2-Q3HuCW-VLv9B8CcGh-zl7E-wwcbTHLQXm-hF1AlcdwnLNWzjW_91VS3l8AimGm__Qg_XNdgDwy-C7k0gUJKlE'),
(37, '1235', 'สวน', '1234', 'user', 'Female', 'teacher', 'eMWqUxbGTVafwAG6y3rn7U:APA91bHnDVOuZCQIegMQY2eVHJx_LM_7pRYOMwMzqZoVfbRyo65pGn2qjl_VAd5c7L69UUtFkTWkr2i5yeZuIGGsrOYvMhZZkXNHOU5_In7FFQUVr-r1bUHWzQCtPmG0es86Ly45x2GF'),
(38, 'ยวน', '123', '44556', 'user', 'Female', 'student', 'cMR5K-kKQJKNDyz_qaZIdw:APA91bHvhBu5_ze5CC2DN1OHJV-YsI2S-5iS49FjP8pv7hFkodiTs0H_qQ1Fz5GSWG2_WIJocjCIzBIGyjeoMTdgVALhDRrgSDPkHzeQGBxd9BQgSC9jyJ_eeoF1n-hqaYCRWxMUrihu'),
(39, '123789', 'ตตตต', '1234', 'user', 'Female', 'student', 'eMWqUxbGTVafwAG6y3rn7U:APA91bHnDVOuZCQIegMQY2eVHJx_LM_7pRYOMwMzqZoVfbRyo65pGn2qjl_VAd5c7L69UUtFkTWkr2i5yeZuIGGsrOYvMhZZkXNHOU5_In7FFQUVr-r1bUHWzQCtPmG0es86Ly45x2GF'),
(40, 'สสส', 'สสส', 'สสส', 'user', 'Female', 'teacher', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3');

-- --------------------------------------------------------

--
-- Table structure for table `warninglist`
--

CREATE TABLE `warninglist` (
  `id` int(11) NOT NULL,
  `DateTime_warning` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idUser` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nameUser` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nameForm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idBuildForm` text NOT NULL,
  `buildForm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `build_kk` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `floors_pp` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `numRoom` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `moreForm` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `airForm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `agency` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileIMG` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileIMG2` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_date` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `time_end` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double NOT NULL,
  `id_mtn` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `mtn_autoID` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `mtn_name` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warninglist`
--

INSERT INTO `warninglist` (`id`, `DateTime_warning`, `time`, `idUser`, `nameUser`, `nameForm`, `idBuildForm`, `buildForm`, `build_kk`, `floors_pp`, `numRoom`, `moreForm`, `airForm`, `agency`, `phone`, `fileIMG`, `fileIMG2`, `status`, `end_date`, `time_end`, `token`, `rate`, `id_mtn`, `mtn_autoID`, `mtn_name`) VALUES
(66, '', '', 'gfggrege', 'kkkkkkkk', '$nameForm', '', '1', '', '', '', '', '12', '', '', '55555', '', '5555', '', '', '555222', 0, '', '', ''),
(67, 'วันอาทิตย์ที่ 9 พฤษภาคม ค.ศ. 2021', '23:24', '38', '123', '่สทท', '216', 'อาคาร 1 ชั้น 4 หอประชุมใหญ่', '', '', '', '', '้ทื', '่สมท', '569.0', '/appkk/warninglist/BU83855.jpg', '/appkk/warninglist/BU2_46929.jpg', 'FInish', 'วันอาทิตย์ที่ 9 พฤษภาคม ค.ศ. 2021', 'null', 'cMR5K-kKQJKNDyz_qaZIdw:APA91bHvhBu5_ze5CC2DN1OHJV-YsI2S-5iS49FjP8pv7hFkodiTs0H_qQ1Fz5GSWG2_WIJocjCIzBIGyjeoMTdgVALhDRrgSDPkHzeQGBxd9BQgSC9jyJ_eeoF1n-hqaYCRWxMUrihu', 0, '', '', ''),
(68, 'วันอาทิตย์ที่ 9 พฤษภาคม ค.ศ. 2021', '23:37', '38', '123', 'ื', '97', '300407 ห้องควบคุมเครื่องแม่ข่าย', '', '', '', '', 'ื', 'ั', '5', '/appkk/warninglist/BU20342.jpg', '/appkk/warninglist/BU2_32389.jpg', 'FInish', 'วันอาทิตย์ที่ 9 พฤษภาคม ค.ศ. 2021', '13:43', 'cMR5K-kKQJKNDyz_qaZIdw:APA91bHvhBu5_ze5CC2DN1OHJV-YsI2S-5iS49FjP8pv7hFkodiTs0H_qQ1Fz5GSWG2_WIJocjCIzBIGyjeoMTdgVALhDRrgSDPkHzeQGBxd9BQgSC9jyJ_eeoF1n-hqaYCRWxMUrihu', 0, '', '', ''),
(69, 'วันจันทร์ที่ 10 พฤษภาคม ค.ศ. 2021', '13:23', '21', 'ชัชชัย สน', 'สนยส', 'null', '300513 ห้องปฏิบัติการเทคโนโลยีและสื่อสารการศึกษา2', '', '', '', '', 'อม ', 'อม ', '89', '/appkk/warninglist/BU19096.jpg', '/appkk/warninglist/BU2_85403.jpg', 'FInish', 'null', 'null', 'eRUxNEYXR1SfV2cZVzqBEp:APA91bE5XBIxzbcHnNeQXJB2puhcZTzjx1hm1vamQBPnlSIS2KrrnX0Meb9V5l0Y1JplPZhICncTQPeWUWVOKwM2zVmkNHCTQ9FyKhO-gi8V1Q_KZ_8sWBz9SOp6AS2vWGy3bE78zCzy', 0, '', '', ''),
(70, 'วันจันทร์ที่ 10 พฤษภาคม ค.ศ. 2021', '13:26', '21', 'ชัชชัย สน', 'ร', '99', '300410 ศูนย์ปฏิบัติการทางภาษา', '', '', '', '', 'ุ', 'พ', '5', '/appkk/warninglist/BU17925.jpg', '/appkk/warninglist/BU2_86147.jpg', 'FInish', 'วันศุกร์ที่ 14 พฤษภาคม ค.ศ. 2021', '22:16', 'eRUxNEYXR1SfV2cZVzqBEp:APA91bE5XBIxzbcHnNeQXJB2puhcZTzjx1hm1vamQBPnlSIS2KrrnX0Meb9V5l0Y1JplPZhICncTQPeWUWVOKwM2zVmkNHCTQ9FyKhO-gi8V1Q_KZ_8sWBz9SOp6AS2vWGy3bE78zCzy', 0, '', '', ''),
(71, 'วันศุกร์ที่ 14 พฤษภาคม ค.ศ. 2021', '20:17', '37', 'สวน', '้ยส', '35', '2101 ห้องบรรยาย 1', '', '', '', '', '้ส', 'ันา', '39', '/appkk/warninglist/BU67860.jpg', '/appkk/warninglist/BU2_19196.jpg', 'review', '', '', 'eMWqUxbGTVafwAG6y3rn7U:APA91bHnDVOuZCQIegMQY2eVHJx_LM_7pRYOMwMzqZoVfbRyo65pGn2qjl_VAd5c7L69UUtFkTWkr2i5yeZuIGGsrOYvMhZZkXNHOU5_In7FFQUVr-r1bUHWzQCtPmG0es86Ly45x2GF', 5, '', '', ''),
(72, 'วันอาทิตย์ที่ 23 พฤษภาคม ค.ศ. 2021', '18:30', '11', 'กชมล เชื้อวงศ์พรหม', 'ไฟดับ', '29', '281 ห้องบรรยาย 1', '', '', '', '', '', 'ตต', '06523', '/appkk/warninglist/BU71688.jpg', '/appkk/warninglist/BU2_52973.jpg', 'review', '', '', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3', 2.5, '', '', ''),
(73, 'วันอาทิตย์ที่ 23 พฤษภาคม ค.ศ. 2021', '19:11', '11', 'กชมล เชื้อวงศ์พรหม', 'ไฟดับ', '18', '242 ห้องปฏิบัติการด้านดอกไม้', '', '', '', '', '', 'กองคลัง', '086532896263', '/appkk/warninglist/BU34439.jpg', '/appkk/warninglist/BU2_76361.jpg', 'UserWarning', 'NO Date', 'NO time', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3', 0, '', 'mtn718', ''),
(74, 'วันจันทร์ที่ 24 พฤษภาคม ค.ศ. 2021', '12:17', '40', 'สสส', 'ส', '54', '1131 สำนักวิเทศสัมพันธ์และเครือข่ายอาเซียน', '', '', '', '', 'ี', '', '9869', '/appkk/warninglist/BU30043.jpg', '/appkk/warninglist/BU2_31964.jpg', 'UserWarning', 'NO Date', 'NO time', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3', 0, '', 'mtn718', ''),
(75, 'วันจันทร์ที่ 24 พฤษภาคม ค.ศ. 2021', '12:26', '40', 'สสส', 'เ', '212', '222 ห้องปฏิบัติการอาหารและเบเกอรี่', '', '', '', '', '่', '', '5', '/appkk/warninglist/BU66086.jpg', '/appkk/warninglist/BU2_92976.jpg', 'UserWarning', 'NO Date', 'NO time', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3', 0, '', '', ''),
(76, 'วันจันทร์ที่ 24 พฤษภาคม ค.ศ. 2021', '12:29', '40', 'สสส', 'ี', '213', '231 ห้องพักอาจารย์', '', '', '', '', '่', '', '9', '/appkk/warninglist/BU86671.jpg', '/appkk/warninglist/BU2_88017.jpg', 'UserWarning', 'NO Date', 'NO time', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3', 0, '', '', ''),
(77, 'วันจันทร์ที่ 24 พฤษภาคม ค.ศ. 2021', '12:32', '40', 'สสส', 'ื', '93', '300403 ห้องประชุม', '', '', '', '', '่', '', '6', '/appkk/warninglist/BU62345.jpg', '/appkk/warninglist/BU2_63395.jpg', 'UserWarning', 'NO Date', 'NO time', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3', 0, '', '', ''),
(78, 'วันจันทร์ที่ 24 พฤษภาคม ค.ศ. 2021', '12:43', '40', 'สสส', 'ื', '94', '300404 สาขาวิชาชีววิทยา', '', '', '', '', 'ว', '', '9', '/appkk/warninglist/BU29720.jpg', '/appkk/warninglist/BU2_69626.jpg', 'UserWarning', 'NO Date', 'NO time', 'fztINU51RtKPA5R-Kdcevg:APA91bGfTnx60ni2Mp5tgaE8_O1ILxI1apClFsydx9hHH_Zx4pcIsPFk9EyTMhzuGLhk0qUn2sLoZxZyG78fsFKedZfzUn6XFokS06zpnw44TmSMVMdhiauCm4YEIBW2kLdUc8IaW8H3', 0, '', '', ''),
(79, 'วันจันทร์ที่ 24 พฤษภาคม ค.ศ. 2021', '12:53', '25', 'kkk', 'b', '40', '2113 Asgard Animation Lab', '', '', '', '', 'g', '', '8', '/appkk/warninglist/BU61189.jpg', '/appkk/warninglist/BU2_88451.jpg', 'UserWarning', 'NO Date', 'NO time', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 0, '', '', ''),
(80, 'วันจันทร์ที่ 24 พฤษภาคม พ.ศ. 2564', '12:59', '25', 'kkk', 'n', '39', '2112 Pandora Animation Lab', '', '', '', '', 'b', '', '6', '/appkk/warninglist/BU42385.jpg', '/appkk/warninglist/BU2_16071.jpg', 'UserWarning', 'NO Date', 'NO time', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 0, '', '', ''),
(81, '59689 9', '256565 ', '1', 'lloo', '$nameForm', '92', '1', '5', '5', '545848478', '5655496549', '5', '5', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5, '', '', ''),
(82, '59689 9', '256565 ', '1', 'lloo', '$nameForm', '92', '1', '5', '5', '545848478', '5655496549', '5', '5', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5, '', '', ''),
(83, '59689 9', '256565 ', '1', 'lloo', '$nameForm', '92', '1', '5', '5', '5', '5', '545848478', '5655496549', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5, '', '', ''),
(84, 'วันจันทร์ที่ 24 พฤษภาคม พ.ศ. 2564', '20:46', '25', 'kkk', 'ส', '1', '', '1', '', '3', '', 'ง', '', '9', '/appkk/warninglist/BU93569.jpg', '/appkk/warninglist/BU2_81416.jpg', 'UserWarning', 'NO Date', 'NO time', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 0, '', '', ''),
(85, 'วันจันทร์ที่ 24 พฤษภาคม พ.ศ. 2564', '20:49', '25', 'kkk', 'บ', '1', '', '1', '2', '3', '', 'ม', '', '9', '/appkk/warninglist/BU52044.jpg', '/appkk/warninglist/BU2_58792.jpg', 'FInish', 'วันพุธที่ 2 มิถุนายน ค.ศ. 2021', '21:50', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 0, '8', 'mtn172', 'ยนตรี'),
(86, 'วันจันทร์ที่ 24 พฤษภาคม พ.ศ. 2564', '21:02', '25', 'kkk', '่าสน', '1', '', '1', '2', '3', '', '่เะกก', '', '8852', '/appkk/warninglist/BU27561.jpg', '/appkk/warninglist/BU2_71634.jpg', 'review', '', '', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 1, '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `building`
--
ALTER TABLE `building`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `floors`
--
ALTER TABLE `floors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`build_id`);

--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`id_mtn`);

--
-- Indexes for table `rate`
--
ALTER TABLE `rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warninglist`
--
ALTER TABLE `warninglist`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=220;

--
-- AUTO_INCREMENT for table `floors`
--
ALTER TABLE `floors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `build_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `id_mtn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `rate`
--
ALTER TABLE `rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `warninglist`
--
ALTER TABLE `warninglist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
