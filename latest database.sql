-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 15, 2022 at 02:46 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doc`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertorupdateformvalue` (IN `formentryid` INT(11), IN `formfieldid` INT(11), IN `fieldvalue` VARCHAR(225))  BEGIN
if not exists (Select form_entry_data_id from form_entry_data where form_entry_id=formentryid and form_fields_id=formfieldid) then
insert into form_entry_data (form_entry_id, form_fields_id, `value`) values (formentryid, formfieldid, fieldvalue);
commit;
else
update form_entry_data set `value`=fieldvalue  where form_entry_id=formentryid and form_fields_id=formfieldid;
commit;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTLIST` (IN `c_form_id` INT)  BEGIN

SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when label = ''',
      label,
      ''' then Value end) '
      
    )
  ) INTO @sql
FROM
  reportdata where form_id = c_form_id;
SET @sql = CONCAT('SELECT patient_id, ', @sql, ' 
                  FROM reportdata  where form_id = ',c_form_id,'
                   GROUP BY patient_id');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `sno` int(11) NOT NULL,
  `address` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`sno`, `address`) VALUES
(8, 'Islamabad');

-- --------------------------------------------------------

--
-- Table structure for table `audittrail`
--

CREATE TABLE `audittrail` (
  `sno` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `form_id` int(11) DEFAULT NULL,
  `event` varchar(200) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `audittrail`
--

INSERT INTO `audittrail` (`sno`, `username`, `form_id`, `event`, `date`) VALUES
(1, 'admin', NULL, 'Study Add Opened', '2022-01-15 11:02:48'),
(2, 'admin', NULL, 'Study Form Added', '2022-01-15 11:03:51'),
(3, 'admin', NULL, 'Study Form Added', '2022-01-15 11:03:51'),
(4, 'admin', NULL, 'Study Form Added', '2022-01-15 11:03:51'),
(5, 'admin', NULL, 'Study Add Opened', '2022-01-15 11:03:52'),
(6, 'admin', NULL, 'Add Address Opened', '2022-01-15 11:05:21'),
(7, 'admin', NULL, 'Address Added', '2022-01-15 11:05:34'),
(8, 'admin', NULL, 'Add Address Opened', '2022-01-15 11:05:34'),
(9, 'admin', NULL, 'User List Viewed', '2022-01-15 11:05:49'),
(10, 'admin', NULL, 'Add Address Opened', '2022-01-15 11:05:54'),
(11, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 11:05:59'),
(12, 'admin', NULL, 'Case Detail Opened', '2022-01-15 11:06:05'),
(13, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 11:06:08'),
(14, 'admin', NULL, 'Case View List Opened', '2022-01-15 11:06:09'),
(15, 'admin', NULL, 'Case View List Opened', '2022-01-15 11:06:18'),
(16, 'admin', NULL, 'User Created', '2022-01-15 11:06:23'),
(17, 'naqvi29', NULL, 'User Added', '2022-01-15 11:06:55'),
(18, 'admin', NULL, 'User Created', '2022-01-15 11:06:55'),
(19, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 11:07:43'),
(20, 'naqvi29', NULL, 'Case Report List Viewed', '2022-01-15 11:07:48'),
(21, 'naqvi29', NULL, 'Case Detail Opened', '2022-01-15 11:07:50'),
(22, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 11:07:53'),
(23, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 11:08:34'),
(24, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 11:21:12'),
(25, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 11:21:13'),
(26, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 11:26:36'),
(27, 'admin', NULL, 'Study Add Opened', '2022-01-15 11:26:53'),
(28, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 11:27:08'),
(29, 'admin', NULL, 'Case View List Opened', '2022-01-15 11:27:12'),
(30, 'admin', NULL, 'Add Patient Opened', '2022-01-15 11:27:41'),
(31, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 11:34:33'),
(32, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 11:48:19'),
(33, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 11:48:22'),
(34, 'admin', NULL, 'User Rights List Opened', '2022-01-15 11:49:23'),
(35, 'admin', NULL, 'User Rights Opened', '2022-01-15 11:49:26'),
(36, 'admin', NULL, 'User Rights Updated', '2022-01-15 11:49:28'),
(37, 'admin', NULL, 'User Rights Update Opened', '2022-01-15 11:49:28'),
(38, 'admin', NULL, 'User Rights List Opened', '2022-01-15 11:49:28'),
(39, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 11:49:56'),
(40, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 11:50:02'),
(41, 'naqvi29', NULL, 'Case Report List Viewed', '2022-01-15 11:50:31'),
(42, 'naqvi29', NULL, 'Case Detail Opened', '2022-01-15 11:50:33'),
(43, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 11:50:40'),
(44, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 12:02:38'),
(45, 'admin', NULL, 'Study Add Opened', '2022-01-15 12:03:22'),
(46, 'admin', NULL, 'Study Add Opened', '2022-01-15 12:03:32'),
(47, 'admin', NULL, 'Study Add Opened', '2022-01-15 12:09:18'),
(48, 'admin', NULL, 'Study Form Added', '2022-01-15 12:09:59'),
(49, 'admin', NULL, 'Study Form Added', '2022-01-15 12:09:59'),
(50, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:11:28'),
(51, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:11:39'),
(52, 'admin', NULL, 'Add Patient Opened', '2022-01-15 12:11:55'),
(53, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:16:53'),
(54, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:17:02'),
(55, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:17:08'),
(56, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:17:16'),
(57, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:17:23'),
(58, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:18:08'),
(59, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:18:15'),
(60, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:19:02'),
(61, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:19:48'),
(62, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:19:51'),
(63, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:19:56'),
(64, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:20:26'),
(65, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:20:30'),
(66, 'admin', NULL, 'Project User Rights List Opened', '2022-01-15 12:20:43'),
(67, 'admin', NULL, 'User Rights Details Opened', '2022-01-15 12:20:46'),
(68, 'admin', NULL, 'User Rights Details Opened', '2022-01-15 12:20:49'),
(69, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 12:20:56'),
(70, 'admin', NULL, 'Case Listing for Patients Rights Opened', '2022-01-15 12:20:59'),
(71, 'admin', NULL, 'Case Detail Opened', '2022-01-15 12:21:21'),
(72, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 12:21:26'),
(73, 'admin', NULL, 'Case Listing for Patients Rights Opened', '2022-01-15 12:21:28'),
(74, 'admin', NULL, 'Case Detail Opened', '2022-01-15 12:21:42'),
(75, 'admin', NULL, 'Patient List Opened', '2022-01-15 12:21:47'),
(76, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:21:50'),
(77, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:23:48'),
(78, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:24:11'),
(79, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:24:15'),
(80, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:24:18'),
(81, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:30:15'),
(82, 'admin', NULL, 'Study Add Opened', '2022-01-15 12:34:31'),
(83, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:34:35'),
(84, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:34:49'),
(85, 'admin', NULL, 'Study Add Opened', '2022-01-15 12:34:51'),
(86, 'admin', NULL, 'Study Form Added', '2022-01-15 12:35:20'),
(87, 'admin', NULL, 'Study Add Opened', '2022-01-15 12:35:20'),
(88, 'admin', NULL, 'User Rights List Opened', '2022-01-15 12:35:38'),
(89, 'admin', NULL, 'User Rights Opened', '2022-01-15 12:35:41'),
(90, 'admin', NULL, 'Project User Rights List Opened', '2022-01-15 12:35:45'),
(91, 'admin', NULL, 'User Rights Details Opened', '2022-01-15 12:35:48'),
(92, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 12:35:54'),
(93, 'admin', NULL, 'Case Listing for Patients Rights Opened', '2022-01-15 12:35:56'),
(94, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 12:35:58'),
(95, 'admin', NULL, 'User List Viewed', '2022-01-15 12:36:01'),
(96, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 12:36:06'),
(97, 'admin', NULL, 'User List Viewed', '2022-01-15 12:36:09'),
(98, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:36:13'),
(99, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 12:36:27'),
(100, 'naqvi29', NULL, 'Case Report List Viewed', '2022-01-15 12:36:31'),
(101, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:36:34'),
(102, 'admin', NULL, 'Study Project list Openend', '2022-01-15 12:36:52'),
(103, 'admin', NULL, 'Study Edit Opened', '2022-01-15 12:36:56'),
(104, 'admin', NULL, 'Study Project list Openend', '2022-01-15 12:37:00'),
(105, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 12:37:02'),
(106, 'admin', NULL, 'Case Listing for Patients Rights Opened', '2022-01-15 12:37:05'),
(107, 'admin', NULL, 'Case Report List Viewed', '2022-01-15 12:37:08'),
(108, 'admin', NULL, 'Case Listing for Patients Rights Opened', '2022-01-15 12:37:09'),
(109, 'admin', NULL, 'User List Viewed', '2022-01-15 12:37:19'),
(110, 'admin', NULL, 'User List Viewed', '2022-01-15 12:40:24'),
(111, 'admin', NULL, 'User List Viewed', '2022-01-15 12:40:32'),
(112, 'admin', NULL, 'User List Viewed', '2022-01-15 12:40:44'),
(113, 'admin', NULL, 'User List Viewed', '2022-01-15 12:40:52'),
(114, 'admin', NULL, 'Edit User Opened', '2022-01-15 12:41:01'),
(115, 'admin', NULL, 'User List Viewed', '2022-01-15 12:41:21'),
(116, 'admin', NULL, 'User List Viewed', '2022-01-15 12:41:39'),
(117, 'admin', NULL, 'User List Viewed', '2022-01-15 12:41:59'),
(118, 'admin', NULL, 'User List Viewed', '2022-01-15 12:42:10'),
(119, 'admin', NULL, 'User List Viewed', '2022-01-15 12:42:25'),
(120, 'admin', NULL, 'User List Viewed', '2022-01-15 12:42:30'),
(121, 'admin', NULL, 'User List Viewed', '2022-01-15 12:42:52'),
(122, 'admin', NULL, 'User List Viewed', '2022-01-15 12:42:56'),
(123, 'admin', NULL, 'User List Viewed', '2022-01-15 12:43:11'),
(124, 'admin', NULL, 'Edit User Opened', '2022-01-15 12:43:21'),
(125, 'admin', NULL, 'User Data Updated', '2022-01-15 12:43:29'),
(126, 'admin', NULL, 'User List Viewed', '2022-01-15 12:43:29'),
(127, 'admin', NULL, 'Case View List Opened', '2022-01-15 12:44:16'),
(128, 'admin', NULL, 'User List Viewed', '2022-01-15 12:44:21'),
(129, 'admin', NULL, 'Edit User Opened', '2022-01-15 12:44:30'),
(130, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 12:45:32'),
(131, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:45:36'),
(132, 'naqvi29', NULL, 'Case Report List Viewed', '2022-01-15 12:45:40'),
(133, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:45:43'),
(134, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:45:50'),
(135, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:45:58'),
(136, 'naqvi29', NULL, 'Case Report List Viewed', '2022-01-15 12:46:03'),
(137, 'naqvi29', NULL, 'Case Detail Opened', '2022-01-15 12:46:05'),
(138, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:46:08'),
(139, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:46:19'),
(140, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 12:46:49'),
(141, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:48:14'),
(142, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 12:48:28'),
(143, 'naqvi29', NULL, 'Edit User Opened', '2022-01-15 12:49:13'),
(144, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 12:49:29'),
(145, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 13:02:21'),
(146, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 13:03:04'),
(147, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 13:07:33'),
(148, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:08:00'),
(149, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:08:43'),
(150, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 13:09:26'),
(151, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:09:26'),
(152, 'naqvi29', NULL, 'Add Patient Opened', '2022-01-15 13:10:23'),
(153, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:10:23'),
(154, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:10:36'),
(155, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:12:14'),
(156, 'admin', NULL, 'Case View List Opened', '2022-01-15 13:18:45'),
(157, 'admin', NULL, 'Study Add Opened', '2022-01-15 13:18:56'),
(158, 'admin', NULL, 'Project User Rights List Opened', '2022-01-15 13:19:08'),
(159, 'admin', NULL, 'User Rights Details Opened', '2022-01-15 13:19:10'),
(160, 'naqvi29', NULL, 'Dashboard Opened', '2022-01-15 13:19:21'),
(161, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:24:09'),
(162, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:24:28'),
(163, 'naqvi29', NULL, 'Case Report List Viewed', '2022-01-15 13:24:44'),
(164, 'naqvi29', NULL, 'Case Detail Opened', '2022-01-15 13:24:47'),
(165, 'naqvi29', NULL, 'Case Patient Study Opened', '2022-01-15 13:24:50'),
(166, 'naqvi29', NULL, 'Case Report List Viewed', '2022-01-15 13:24:56'),
(167, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:25:00'),
(168, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:28:23'),
(169, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:32:10'),
(170, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:35:39'),
(171, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:35:41'),
(172, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:36:02'),
(173, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:36:43'),
(174, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:37:20'),
(175, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:38:25'),
(176, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:39:35'),
(177, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:39:47'),
(178, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:40:13'),
(179, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:40:48'),
(180, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:42:11'),
(181, 'naqvi29', NULL, 'Case View List Opened', '2022-01-15 13:42:21'),
(182, 'naqvi29', NULL, 'Case Data Add Opened', '2022-01-15 13:42:52');

-- --------------------------------------------------------

--
-- Table structure for table `case_report`
--

CREATE TABLE `case_report` (
  `id` int(11) NOT NULL,
  `case_form_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `consent_obtained_date` date NOT NULL,
  `written_informed_consent_obtained` varchar(255) NOT NULL,
  `date_of_obtaining_informed_consent` date NOT NULL,
  `initial_assesment_age` varchar(255) NOT NULL,
  `body_weight` varchar(255) NOT NULL,
  `body_height` varchar(255) NOT NULL,
  `body_mass_index` varchar(255) NOT NULL,
  `suitable_enrollment_into_the_` varchar(255) NOT NULL,
  `final_inclusion_date` date NOT NULL,
  `included_by` varchar(255) NOT NULL,
  `tablet_x_administered` varchar(255) NOT NULL,
  `time_of_administration` varchar(255) NOT NULL,
  `date_of_adminstration` date NOT NULL,
  `administered_by` varchar(255) NOT NULL,
  `vital_sign_date` date NOT NULL,
  `actual_time` time NOT NULL,
  `temprature` varchar(255) NOT NULL,
  `heart_rate_bpm` varchar(255) NOT NULL,
  `blood_pressure_diastolic` varchar(255) NOT NULL,
  `blood_pressure_systolic` varchar(255) NOT NULL,
  `comments` varchar(255) NOT NULL,
  `symptoms_relieved_10_mins_after_drug` varchar(255) NOT NULL,
  `symptoms_relieved_20_mins_after_drug` varchar(255) NOT NULL,
  `symptoms_relieved_30_mins_after_drug` varchar(255) NOT NULL,
  `duration_of_symptoms_relief_after_drug` varchar(255) NOT NULL,
  `treatment_succes` varchar(255) NOT NULL,
  `time_of_symptoms_relief_minutes` varchar(255) NOT NULL,
  `symptoms_relief_date` date NOT NULL,
  `compliance_to_instructions` varchar(255) NOT NULL,
  `compliance_vital_sign_` varchar(255) NOT NULL,
  `cold_symptoms_relieved_after_drug` varchar(255) NOT NULL,
  `study_conclusion_date` date NOT NULL,
  `normal_study_completion` varchar(255) NOT NULL,
  `patient_have_any_congestion_feeling` tinyblob NOT NULL,
  `patient_have_throat_irritation` varchar(255) NOT NULL,
  `patient_have_feeling_of_sleep` varchar(255) NOT NULL,
  `completed_by` varchar(255) NOT NULL,
  `complition_date` date NOT NULL,
  `name_and_signature_qa` varchar(255) NOT NULL,
  `subject_code` varchar(255) NOT NULL,
  `medical_record_no` varchar(255) NOT NULL,
  `name_and_signature_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `digital_signature`
--

CREATE TABLE `digital_signature` (
  `id_digital_signature` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `signature` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `digital_signature`
--

INSERT INTO `digital_signature` (`id_digital_signature`, `user_id`, `patient_id`, `signature`) VALUES
(6, 3, 9, 'xyz'),
(7, 3, 9, 'xyz'),
(8, 3, 8, 'xyz'),
(9, 3, 1, 'naqvi');

-- --------------------------------------------------------

--
-- Table structure for table `exclusion_criteria`
--

CREATE TABLE `exclusion_criteria` (
  `id` int(11) NOT NULL,
  `case_form_id` int(11) NOT NULL,
  `age_more_or_less_than` varchar(255) NOT NULL,
  `patient_is_not_the_cold_symptomatic.` varchar(255) NOT NULL,
  `patient_taken_medicine_for_cold_symptoms` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `form`
--

CREATE TABLE `form` (
  `form_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  `project_id` varchar(300) NOT NULL,
  `archive` varchar(30) NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form`
--

INSERT INTO `form` (`form_id`, `title`, `created_at`, `status`, `project_id`, `archive`) VALUES
(52, 'ABC Project', '2022-01-15 11:03:51', 1, 'ABC', 'no'),
(54, 'XYZ Project', '2022-01-15 12:35:20', 1, 'XYZ', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `form_entry`
--

CREATE TABLE `form_entry` (
  `form_entry_id` int(11) NOT NULL,
  `form_id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form_entry`
--

INSERT INTO `form_entry` (`form_entry_id`, `form_id`, `user_id`, `patient_id`, `created_at`) VALUES
(1, 52, 3, 1, '2022-01-15 11:30:51'),
(7, 54, 3, 8, '2022-01-15 13:07:33'),
(9, 52, 3, 10, '2022-01-15 13:10:23');

-- --------------------------------------------------------

--
-- Table structure for table `form_entry_data`
--

CREATE TABLE `form_entry_data` (
  `form_entry_data_id` int(11) NOT NULL,
  `form_entry_id` int(255) NOT NULL,
  `form_fields_id` int(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `form_fields`
--

CREATE TABLE `form_fields` (
  `form_fields_id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `field_type` varchar(255) NOT NULL,
  `field_placeholder` varchar(255) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  `class_column` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `form_id` int(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_required` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form_fields`
--

INSERT INTO `form_fields` (`form_fields_id`, `label`, `field_type`, `field_placeholder`, `field_value`, `class_column`, `sort_order`, `form_id`, `created_at`, `is_required`) VALUES
(1, 'name', 'text', 'Name', '', 'col-md-6', 1, 52, '2022-01-15 11:03:51', 1),
(2, 'age', 'number', 'Age', '', 'col-md-6', 2, 52, '2022-01-15 11:03:51', 1),
(3, 'contact', 'number', 'Contact', '', 'col-md-6', 3, 52, '2022-01-15 11:03:51', 1),
(6, 'name', 'text', 'Name', '', 'col-md-6', 1, 54, '2022-01-15 12:35:20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inclusion_criteria`
--

CREATE TABLE `inclusion_criteria` (
  `id` int(11) NOT NULL,
  `case_form_id` int(10) NOT NULL,
  `Male/Female_age` varchar(255) NOT NULL,
  `cold_symptomatic_patients_routine_check­up` varchar(255) NOT NULL,
  `cold_symptomatic_medicine_prior_check­up` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `patient_name` varchar(255) NOT NULL,
  `contact` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_by` int(11) NOT NULL,
  `status` varchar(30) DEFAULT NULL,
  `p_id` varchar(255) NOT NULL,
  `cnic` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `patient_name`, `contact`, `address`, `created_by`, `status`, `p_id`, `cnic`, `created_at`) VALUES
(1, 'khan', '012121212', '8', 3, NULL, 'ABC', '4545454', '2022-01-15 11:08:34'),
(2, 'patient2', '456', '8', 2, NULL, 'ABC', '4564879', '2022-01-15 11:27:41'),
(9, 'xyz patient', '7897898', '8', 3, NULL, 'XYZ', '789465465', '2022-01-15 13:09:26'),
(8, 'patient', '456465', '8', 3, NULL, 'XYZ', '4545454', '2022-01-15 13:07:33'),
(10, 'Abc patient', '456', 'Islamabad', 3, NULL, 'ABC', '789798', '2022-01-15 13:10:23');

-- --------------------------------------------------------

--
-- Table structure for table `query`
--

CREATE TABLE `query` (
  `query_idd` int(11) NOT NULL,
  `form_idd` int(11) NOT NULL,
  `user_idd` int(11) NOT NULL,
  `patient_idd` int(11) NOT NULL,
  `query` varchar(5000) NOT NULL,
  `query_status` varchar(100) NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `reportdata`
-- (See below for the actual view)
--
CREATE TABLE `reportdata` (
`patient_id` int(11)
,`label` varchar(255)
,`Value` varchar(255)
,`form_id` int(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `rights`
--

CREATE TABLE `rights` (
  `sno` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `editt` varchar(30) DEFAULT NULL,
  `deletee` varchar(30) DEFAULT NULL,
  `addd` varchar(30) DEFAULT NULL,
  `vieww` varchar(20) DEFAULT NULL,
  `lockk` varchar(30) DEFAULT NULL,
  `data_download` varchar(30) NOT NULL DEFAULT 'no',
  `query` varchar(50) NOT NULL DEFAULT 'no',
  `form_id` int(11) NOT NULL,
  `sign` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rights`
--

INSERT INTO `rights` (`sno`, `user_id`, `editt`, `deletee`, `addd`, `vieww`, `lockk`, `data_download`, `query`, `form_id`, `sign`) VALUES
(1, 3, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 52, 'yes'),
(3, 2, 'yes', 'yes', 'yes', 'yes', 'yes', 'no', 'no', 53, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(1025) NOT NULL,
  `contact_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `rep_code` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(45) NOT NULL DEFAULT 'active',
  `role2` varchar(1000) NOT NULL,
  `login_attempt` varchar(100) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `name`, `user_name`, `password`, `contact_number`, `address`, `rep_code`, `role`, `parent_id`, `created_at`, `status`, `role2`, `login_attempt`) VALUES
(2, 'admin', 'admin', 'admin', '03432818381', 'block 10', 0, 1, 0, '2022-01-15 11:02:33', 'active', 'Principal Invesigator', 'active'),
(3, 'Muhammad Ali', 'naqvi29', '1234', '03232629249', '8', 0, 2, 1, '2022-01-15 11:06:55', 'active', 'Data Manager', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `userid`
--

CREATE TABLE `userid` (
  `sno` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userid`
--

INSERT INTO `userid` (`sno`, `user_id`) VALUES
(1, 3),
(2, 3),
(3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_form_permissions`
--

CREATE TABLE `user_form_permissions` (
  `user_form_permissions_id` int(11) NOT NULL,
  `user_id` int(255) NOT NULL,
  `form_id` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_form_permissions`
--

INSERT INTO `user_form_permissions` (`user_form_permissions_id`, `user_id`, `form_id`) VALUES
(2, 3, 52),
(3, 3, 54);

-- --------------------------------------------------------

--
-- Structure for view `reportdata`
--
DROP TABLE IF EXISTS `reportdata`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reportdata`  AS SELECT `patient`.`patient_id` AS `patient_id`, CASE WHEN `v1`.`field_type` = 'radio' THEN (select `form_fields`.`label` from `form_fields` where `form_fields`.`form_fields_id` = `v1`.`form_fields_id` - 1) ELSE `v1`.`label` END AS `label`, CASE WHEN `v1`.`field_type` = 'radio' AND `form_entry_data`.`value` = 1 THEN substring_index(`v1`.`label`,',',1) WHEN `v1`.`field_type` = 'radio' AND `form_entry_data`.`value` = 2 THEN substring_index(`v1`.`label`,',',-1) ELSE `form_entry_data`.`value` END AS `Value`, `v1`.`form_id` AS `form_id` FROM ((((`form_entry` join `user` on(`user`.`user_id` = `form_entry`.`user_id`)) join `patient` on(`form_entry`.`patient_id` = `patient`.`patient_id`)) join `form_entry_data` on(`form_entry_data`.`form_entry_id` = `form_entry`.`form_entry_id`)) join `form_fields` `v1` on(`form_entry`.`form_id` = `v1`.`form_id` and `v1`.`form_fields_id` = `form_entry_data`.`form_fields_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `audittrail`
--
ALTER TABLE `audittrail`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `case_report`
--
ALTER TABLE `case_report`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `digital_signature`
--
ALTER TABLE `digital_signature`
  ADD PRIMARY KEY (`id_digital_signature`);

--
-- Indexes for table `exclusion_criteria`
--
ALTER TABLE `exclusion_criteria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`form_id`);

--
-- Indexes for table `form_entry`
--
ALTER TABLE `form_entry`
  ADD PRIMARY KEY (`form_entry_id`);

--
-- Indexes for table `form_entry_data`
--
ALTER TABLE `form_entry_data`
  ADD PRIMARY KEY (`form_entry_data_id`);

--
-- Indexes for table `form_fields`
--
ALTER TABLE `form_fields`
  ADD PRIMARY KEY (`form_fields_id`);

--
-- Indexes for table `inclusion_criteria`
--
ALTER TABLE `inclusion_criteria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `query`
--
ALTER TABLE `query`
  ADD PRIMARY KEY (`query_idd`);

--
-- Indexes for table `rights`
--
ALTER TABLE `rights`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `userid`
--
ALTER TABLE `userid`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `user_form_permissions`
--
ALTER TABLE `user_form_permissions`
  ADD PRIMARY KEY (`user_form_permissions_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `audittrail`
--
ALTER TABLE `audittrail`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT for table `case_report`
--
ALTER TABLE `case_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `digital_signature`
--
ALTER TABLE `digital_signature`
  MODIFY `id_digital_signature` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `exclusion_criteria`
--
ALTER TABLE `exclusion_criteria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `form`
--
ALTER TABLE `form`
  MODIFY `form_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `form_entry`
--
ALTER TABLE `form_entry`
  MODIFY `form_entry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `form_entry_data`
--
ALTER TABLE `form_entry_data`
  MODIFY `form_entry_data_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=523;

--
-- AUTO_INCREMENT for table `form_fields`
--
ALTER TABLE `form_fields`
  MODIFY `form_fields_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `inclusion_criteria`
--
ALTER TABLE `inclusion_criteria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `query`
--
ALTER TABLE `query`
  MODIFY `query_idd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rights`
--
ALTER TABLE `rights`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `userid`
--
ALTER TABLE `userid`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_form_permissions`
--
ALTER TABLE `user_form_permissions`
  MODIFY `user_form_permissions_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
