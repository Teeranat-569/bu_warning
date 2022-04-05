-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2021 at 07:33 PM
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
(216, 'อาคาร 1 ชั้น 4 หอประชุมใหญ่');

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
  `numRoom` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `house`
--

INSERT INTO `house` (`build_id`, `build_kk`, `floorspp`, `numRoom`) VALUES
(1, '1', '2', '3'),
(2, '1', '1', '0');

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
  `buildForm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rate`
--

INSERT INTO `rate` (`id`, `idWarning`, `rate`, `comment_rec`, `idBuildForm`, `buildForm`) VALUES
(57, 65, 2.5, 'null', '35', '2101 ห้องบรรยาย 1');

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
(2, 'admin', 'admin', 'admin', 'admin', '', '', 'cnWi0wMJTPibXQw4enWgto:APA91bHGchnNGBxh4o4mGKCfRveMMeehIodmwan_lOqaJX4nYTPtG2-Q3HuCW-VLv9B8CcGh-zl7E-wwcbTHLQXm-hF1AlcdwnLNWzjW_91VS3l8AimGm__Qg_XNdgDwy-C7k0gUJKlE'),
(11, '6021207001', 'กชมล เชื้อวงศ์พรหม', '06042541', 'user', 'Female', '', 'eMWqUxbGTVafwAG6y3rn7U:APA91bHaZX5Duf3UdoBbgNRwINE--aNpyavq6yWM3-nxtkMMAALOIR1Pvpt3lCGXstV50r-xUK9qMfpgYfY94175QOtyiUlNictevxHPMd0SlR3a7f8pPNDjMgDUfGAi1nrXvDOhMP89'),
(12, '1234', 'วิวัฒน์', '1234', 'user', 'male', '', 'cnWi0wMJTPibXQw4enWgto:APA91bHGchnNGBxh4o4mGKCfRveMMeehIodmwan_lOqaJX4nYTPtG2-Q3HuCW-VLv9B8CcGh-zl7E-wwcbTHLQXm-hF1AlcdwnLNWzjW_91VS3l8AimGm__Qg_XNdgDwy-C7k0gUJKlE'),
(14, '6021207062', 'ปรวี ทองน้อย', '123456', 'user', 'Female', '', 'cH76bu9mT4q3h0iRS5rxD_:APA91bHMAmXE-59wQ2H3_1HXcuHyBETmEu9i_4QffXELO3-lv-Uur2bK6j3_CszptRnnlNOMLUkKkFAb9taETaL5M88RAHvXZXETHkpKrQy1WM7USDZpuynp3hvsU4zTIcd0NoWKoh6K'),
(15, '60', 'วิวัฒน์', '1234', 'user', 'male', '', 'dcCEz5kGTQ6YQkjKHOfQs9:APA91bEmgKIIsp2w2Avm_Hi9JdvvTo62tYlMktHOB_7wlE6EaSFAVbX8bdmjTzAnWU8hy78UESlxK9GTyIaAn89CWTi9Bp8CJS6bKYXve0wNIo86ZeOYqH_nwn6SQHvPe1kPaSRTJbRy'),
(16, '6021207011', 'สวัสดี', '1234', 'user', 'Female', '', ''),
(17, '602579', 'ราตรี', '1234', 'user', 'male', '', 'eM0G3lx9QbGVj4eGP46Ixl:APA91bHraht778r8vUiMjH01OgCFaLoK5PUl8h1kL3UKdtHOJICk_jPCa4i3blY2ycgQPIVApCNGnEZyrnGOjxzx48R3iUTlDCyaDUufe1TU_W3EmWilI0ABXKRLP-AT3nlTt3R0nW3K'),
(18, '6012', 'ggg', '1234', 'user', 'male', '', ''),
(19, '6012', 'ggg', '1234', 'user', 'male', '55555', ''),
(20, '6021207005', 'อรุณี เผ่าทัพ', '1234', 'user', 'Female', 'student', 'eM0G3lx9QbGVj4eGP46Ixl:APA91bHraht778r8vUiMjH01OgCFaLoK5PUl8h1kL3UKdtHOJICk_jPCa4i3blY2ycgQPIVApCNGnEZyrnGOjxzx48R3iUTlDCyaDUufe1TU_W3EmWilI0ABXKRLP-AT3nlTt3R0nW3K'),
(21, '1234', 'ชัชชัย สน', '1234', 'user', 'male', 'officer', 'cnWi0wMJTPibXQw4enWgto:APA91bHGchnNGBxh4o4mGKCfRveMMeehIodmwan_lOqaJX4nYTPtG2-Q3HuCW-VLv9B8CcGh-zl7E-wwcbTHLQXm-hF1AlcdwnLNWzjW_91VS3l8AimGm__Qg_XNdgDwy-C7k0gUJKlE'),
(22, 'มิวงใ', 'น่นวใ', '1234', 'user', 'male', 'สม่', ''),
(23, 'kjm', 'สสสส', '123', 'user', 'Female', 'teacher', ''),
(24, 'hhh', 'hhh', 'hhh', 'user', 'Female', 'teacher', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(25, 'kkk', 'kkk', 'kkk', 'user', 'Female', 'teacher', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(26, 'qqq', 'qqq', 'qqq', 'user', 'male', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(27, 'www', 'wwe', 'wwe', 'user', 'Female', 'more', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(28, 'rrr', 'rrr', 'rrr', 'user', 'male', 'jklm', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(29, 'ttt', 'ttt', 'ttt', 'user', 'male', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(30, 'yyy', 'yyy', 'yyy', 'user', 'male', 'student', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(31, 'uuu', 'uuu', 'uuu', 'user', 'male', 'สวน', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(32, 'aaa', 'aaa', 'aaa', 'user', 'Female', 'hk', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(33, 'ooo', 'kkk', 'ppp', 'user', 'Female', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI'),
(34, 'ggg', 'ggg', 'ggg', 'user', 'Female', 'officer', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI');

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
  `airForm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `agency` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileIMG` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileIMG2` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_date` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `time_end` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warninglist`
--

INSERT INTO `warninglist` (`id`, `DateTime_warning`, `time`, `idUser`, `nameUser`, `nameForm`, `idBuildForm`, `buildForm`, `airForm`, `agency`, `phone`, `fileIMG`, `fileIMG2`, `status`, `end_date`, `time_end`, `token`, `rate`) VALUES
(47, 'วันพุธที่ 7 เมษายน ค.ศ. 2021', '23:50', '11', 'กชมล เชื้อวงศ์พรหม', 'สวย', '0', '567 วรรณกรรม', '746', 'รนย', '852', '/appkk/warninglist/BU15711.jpg', '/appkk/warninglist/BU2_85297.jpg', 'review', '', '', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI', 2),
(48, 'วันพุธที่ 7 เมษายน ค.ศ. 2021', '23:57', '11', 'กชมล เชื้อวงศ์พรหม', 'นวท', '0', 'ห้องเกีรยติประวัติ บ้านสมเด็จ', 'ปเา', 'อาม', '8990', '/appkk/warninglist/BU32964.jpg', '/appkk/warninglist/BU2_92713.jpg', 'review', '', '', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI', 5),
(49, 'วันพุธที่ 7 เมษายน ค.ศ. 2021', '23:57', '11', 'กชมล เชื้อวงศ์พรหม', 'นวท', '0', 'ห้องเกีรยติประวัติ บ้านสมเด็จ', 'ปเา', 'อาม', '8990', '/appkk/warninglist/BU32964.jpg', '/appkk/warninglist/BU2_92713.jpg', 'review', '', '', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI', 4),
(50, 'วันพฤหัสบดีที่ 15 เมษายน ค.ศ. 2021', '12:18', '11', 'กชมล เชื้อวงศ์พรหม', 'น้ำไม่ไหล', '0', '221 ห้องพักอาจารย์', 'null', 'สวย', '0896523680860', '/appkk/warninglist/BU26632.jpg', '/appkk/warninglist/BU2_14681.jpg', 'review', '', '', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI', 4),
(51, 'วันพุธที่ 28 เมษายน ค.ศ. 2021', '16:34', '11', 'กชมล เชื้อวงศ์พรหม', 'รยวท', '0', '300402 สาขาวิชาวิทยาศาสตร์ทั่วไป', 'ัตนท', '้นวม', '869.', '/appkk/warninglist/BU76929.jpg', '/appkk/warninglist/BU2_47840.jpg', 'review', '', '', 'dNAP1-jJTtOGmxFz3qrT6m:APA91bHyr995YdyvopXuWEtlF_JrJqHXe1S3vwsZQoqYX-ChFuo9Vpyw56zDEySeq8e2dVuy2quvt3iS4vc3pfyoqx62Wm8aJMBkQW_iB1grJZC3sxqUfV7zcE0K-GxW1I8iCQ7qEOVI', 0.5),
(52, 'วันศุกร์ที่ 7 พฤษภาคม ค.ศ. 2021', '22:27', '11', 'กชมล เชื้อวงศ์พรหม', 'ีตบสา', '0', '2101 ห้องบรรยาย 1', 'ัตนส', 'ัตวส', '0965329083', '/appkk/warninglist/BU46588.jpg', '/appkk/warninglist/BU2_88415.jpg', 'review', '', '', 'dv2MLCVdRJ62q9E5FyXKnH:APA91bHeHY6io-Z7uAwHx0Dmxssu5LXer7R2gbQsTM-RzimzN_hXiKiyA6AdGfT5W8xFQdBPexHxC4OgZ2vYdZUqPoZUYEj9bdvYVnGkxDs9yqD7cp-HBNVkGPB5HbV4ZOOIfSywoloG', 4),
(53, 'วันศุกร์ที่ 7 พฤษภาคม ค.ศ. 2021', '22:29', '11', 'กชมล เชื้อวงศ์พรหม', 'คตยสาา', '0', '242 ห้องปฏิบัติการด้านดอกไม้และเสื้อผ้า', 'นยว', 'นยว', '0965329083', '/appkk/warninglist/BU73947.jpg', '/appkk/warninglist/BU2_61935.jpg', 'review', '', '', 'dv2MLCVdRJ62q9E5FyXKnH:APA91bHeHY6io-Z7uAwHx0Dmxssu5LXer7R2gbQsTM-RzimzN_hXiKiyA6AdGfT5W8xFQdBPexHxC4OgZ2vYdZUqPoZUYEj9bdvYVnGkxDs9yqD7cp-HBNVkGPB5HbV4ZOOIfSywoloG', 2.5),
(54, 'วันศุกร์ที่ 7 พฤษภาคม ค.ศ. 2021', '22:33', '11', 'กชมล เชื้อวงศ์พรหม', 'ียวส', '0', '241 ห้องบรรยายสาขาวิชาคหกรรมศาสตร์', 'null', 'ีนยว', '0965329083', '/appkk/warninglist/BU57856.jpg', '/appkk/warninglist/BU2_78666.jpg', 'review', '', '', 'dv2MLCVdRJ62q9E5FyXKnH:APA91bHeHY6io-Z7uAwHx0Dmxssu5LXer7R2gbQsTM-RzimzN_hXiKiyA6AdGfT5W8xFQdBPexHxC4OgZ2vYdZUqPoZUYEj9bdvYVnGkxDs9yqD7cp-HBNVkGPB5HbV4ZOOIfSywoloG', 4),
(55, 'วันศุกร์ที่ 7 พฤษภาคม ค.ศ. 2021', '22:41', '11', 'กชมล เชื้อวงศ์พรหม', 'คตน', '0', '300502 คลินิกแนะแนว', '678', 'คนร', '0965329083', '/appkk/warninglist/BU76687.jpg', '/appkk/warninglist/BU2_73452.jpg', 'UserWarning', 'NO Date', 'NO time', 'dv2MLCVdRJ62q9E5FyXKnH:APA91bHeHY6io-Z7uAwHx0Dmxssu5LXer7R2gbQsTM-RzimzN_hXiKiyA6AdGfT5W8xFQdBPexHxC4OgZ2vYdZUqPoZUYEj9bdvYVnGkxDs9yqD7cp-HBNVkGPB5HbV4ZOOIfSywoloG', 0),
(56, 'วันศุกร์ที่ 7 พฤษภาคม ค.ศ. 2021', '23:10', '11', 'กชมล เชื้อวงศ์พรหม', 'สวม', '0', '242 ห้องปฏิบัติการด้านดอกไม้และเสื้อผ้า', 'นสย', 'สาย', '0965329083', '/appkk/warninglist/BU41918.jpg', '/appkk/warninglist/BU2_75434.jpg', 'UserWarning', 'NO Date', 'NO time', 'eMWqUxbGTVafwAG6y3rn7U:APA91bHaZX5Duf3UdoBbgNRwINE--aNpyavq6yWM3-nxtkMMAALOIR1Pvpt3lCGXstV50r-xUK9qMfpgYfY94175QOtyiUlNictevxHPMd0SlR3a7f8pPNDjMgDUfGAi1nrXvDOhMP89', 0),
(57, 'วันศุกร์ที่ 7 พฤษภาคม ค.ศ. 2021', '23:39', '21', 'ชัชชัย สน', 'ยวสน', '0', '2113 Asgard Animation Lab', 'นสว', 'นวย', '0965329083', '/appkk/warninglist/BU57446.jpg', '/appkk/warninglist/BU2_24575.jpg', 'review', '', '', 'f9WwauO5Q96y0tfTYlhldB:APA91bGZGSFAPUaKh8XJZkxTsbMfPqtSMt80ze_bIMqWTHVAq-XswGRQobe7TcbRZhfleG11Gj9MJPZq0-GY1M6at6f8-9XCPe0ml-n1Bqd62mGqQAiJLCH-NqKZOT66_QE_AT8tF2U8', 2.5),
(58, 'วันเสาร์ที่ 8 พฤษภาคม ค.ศ. 2021', '01:47', '21', 'ชัชชัย สน', 'วยี', '0', '300404 สาขาวิชาชีววิทยา', '้นว', 'ปสว', '09653875', '/appkk/warninglist/BU56380.jpg', '/appkk/warninglist/BU2_54316.jpg', 'review', '', '', 'cnWi0wMJTPibXQw4enWgto:APA91bHGchnNGBxh4o4mGKCfRveMMeehIodmwan_lOqaJX4nYTPtG2-Q3HuCW-VLv9B8CcGh-zl7E-wwcbTHLQXm-hF1AlcdwnLNWzjW_91VS3l8AimGm__Qg_XNdgDwy-C7k0gUJKlE', 0.5),
(59, '59689 9', '256565 ', '1', 'lloo', '$nameForm', '1', '92', '545848478', '5655496549', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5),
(60, '59689 9', '256565 ', '1', 'lloo', '92', '0', '1', '545848478', '5655496549', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5),
(61, '59689 9', '256565 ', '1', 'lloo', '92', '0', '1', '545848478', '5655496549', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5),
(62, '59689 9', '256565 ', '1', 'lloo', '92', '0', '1', '545848478', '5655496549', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5),
(63, '59689 9', '256565 ', '1', 'lloo', '92', '$nameForm', '1', '545848478', '5655496549', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5),
(64, '59689 9', '256565 ', '1', 'lloo', '$nameForm', '92', '1', '545848478', '5655496549', 'dgehg', '$urlpathPIC', '', '1552546', '88956', '454511', '5245', 1.5),
(65, 'วันเสาร์ที่ 8 พฤษภาคม ค.ศ. 2021', '13:51', '21', 'ชัชชัย สน', 'สน', '35', '2101 ห้องบรรยาย 1', 'สน', 'สน', '085', '/appkk/warninglist/BU65769.jpg', '/appkk/warninglist/BU2_22685.jpg', 'review', '', '', 'cnWi0wMJTPibXQw4enWgto:APA91bHGchnNGBxh4o4mGKCfRveMMeehIodmwan_lOqaJX4nYTPtG2-Q3HuCW-VLv9B8CcGh-zl7E-wwcbTHLQXm-hF1AlcdwnLNWzjW_91VS3l8AimGm__Qg_XNdgDwy-C7k0gUJKlE', 2.5);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `floors`
--
ALTER TABLE `floors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `build_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rate`
--
ALTER TABLE `rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `warninglist`
--
ALTER TABLE `warninglist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
