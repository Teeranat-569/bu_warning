-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2021 at 09:53 AM
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
(3, '', '', '5'),
(5, '', '', ''),
(6, '', '', ''),
(7, '', '3', ''),
(8, '', '', ''),
(9, '1', '', ''),
(10, '', '', ''),
(11, '', '1', ''),
(12, '', '', ''),
(13, '3', '', ''),
(14, '', '', ''),
(15, '', '', '2'),
(16, '', '2', '');

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
  `build_kk` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `floors_pp` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `numRoom` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `moreForm` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rate`
--

INSERT INTO `rate` (`id`, `idWarning`, `rate`, `comment_rec`, `build_kk`, `floors_pp`, `numRoom`, `moreForm`) VALUES
(62, 86, 1, 'kkk', '1', '2', '3', ''),
(63, 86, 1, 'kkk', '1', '2', '3', ''),
(64, 88, 2, 'mmmmm', '0', '3', '5', ''),
(65, 85, 3, 'null', '1', '2', '3', ''),
(66, 85, 3.5, 'null', '1', '2', '3', ''),
(67, 85, 2.5, 'null', '1', '2', '3', ''),
(68, 85, 2.5, '65526', '', '', '', 'jnpijop[');

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
  `build_kk` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `floors_pp` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `numRoom` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `moreForm` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `airForm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileIMG` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileIMG2` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_date` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `time_end` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double NOT NULL,
  `comment_rec` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `mtn_autoID` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warninglist`
--

INSERT INTO `warninglist` (`id`, `DateTime_warning`, `time`, `idUser`, `nameUser`, `nameForm`, `build_kk`, `floors_pp`, `numRoom`, `moreForm`, `airForm`, `phone`, `fileIMG`, `fileIMG2`, `status`, `end_date`, `time_end`, `token`, `rate`, `comment_rec`, `mtn_autoID`) VALUES
(84, 'วันจันทร์ที่ 24 พฤษภาคม พ.ศ. 2564', '20:46', '25', 'kkk', 'ส', '1', '', '3', '', 'ง', '9', '/appkk/warninglist/BU93569.jpg', '/appkk/warninglist/BU2_81416.jpg', 'UserWarning', 'NO Date', 'NO time', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 0, '', ''),
(85, 'วันจันทร์ที่ 24 พฤษภาคม พ.ศ. 2564', '20:49', '25', 'kkk', 'บ', '1', '2', '3', '', 'ม', '9', '/appkk/warninglist/BU52044.jpg', '/appkk/warninglist/BU2_58792.jpg', 'review', '215', '545', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 2.5, '', 'mtn172'),
(86, 'วันจันทร์ที่ 24 พฤษภาคม พ.ศ. 2564', '21:02', '25', 'kkk', '่าสน', '1', '2', '3', '', '่เะกก', '8852', '/appkk/warninglist/BU27561.jpg', '/appkk/warninglist/BU2_71634.jpg', 'Fix', '', '', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 1, '', ''),
(87, 'วันอาทิตย์ที่ 6 มิถุนายน พ.ศ. 2564', '22:52', '25', 'kkk', 'จจจ', '0', '3', '5', '', 'คคค', '222', '/appkk/warninglist/BU24709.jpg', '/appkk/warninglist/BU2_24474.jpg', 'UserWarning', 'NO Date', 'NO time', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 0, '', 'mtn718'),
(88, 'วันอาทิตย์ที่ 6 มิถุนายน พ.ศ. 2564', '23:15', '25', 'kkk', '่ยม', '0', '3', '5', '', 'ิรส', '6655', '/appkk/warninglist/BU46987.jpg', '/appkk/warninglist/BU2_21742.jpg', 'review', '', '', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 2, '', 'mtn718'),
(89, 'วันจันทร์ที่ 7 มิถุนายน พ.ศ. 2564', '21:47', '25', 'kkk', 'vjm', '1', '4', '5', '', 'gk ', '96.0', '/appkk/warninglist/BU49189.jpg', '/appkk/warninglist/BU2_41380.jpg', 'FInish', 'วันจันทร์ที่ 9 มิถุนายน พ.ศ. 2564', '12:47', 'eeu-Hbm0StiP3dWXbKtzvF:APA91bHFqesICDAIDIgnnfHflGExlbxsvlVOOPhAdofjI1aR_DVqx6MvaERe7nqFcSv3oKsv_vyjHsCgqiHROSpe-O2SDaCtdHHowqvI1Xg2rfDKE7DvbxLtvekgDk110WXO9DKfS2yh', 0, '', '');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `build_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `id_mtn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `rate`
--
ALTER TABLE `rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `warninglist`
--
ALTER TABLE `warninglist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
