-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 21, 2020 at 12:16 AM
-- Server version: 10.3.16-MariaDB
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
-- Database: `id12882339_inf1343`
--

-- --------------------------------------------------------

--
-- Table structure for table `channel`
--

CREATE TABLE `channel` (
  `channel_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `gmail_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_picture` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `library`
--

CREATE TABLE `library` (
  `library_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `gmail_address` varchar(64) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `record_in`
--

CREATE TABLE `record_in` (
  `is_history` tinyint(1) DEFAULT 0,
  `is_watch_later` tinyint(1) DEFAULT 0,
  `is_liked` tinyint(1) DEFAULT 0,
  `library_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `video_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `gmail_address` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `content` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `video_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `channel_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `comment` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `duration` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `type` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `feature` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `like` int(11) NOT NULL DEFAULT 0,
  `dislike` int(11) NOT NULL DEFAULT 0,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `published_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youtube_user`
--

CREATE TABLE `youtube_user` (
  `gmail_address` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `photo` longblob DEFAULT NULL,
  `gender` enum('male','female') COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secondary_email` varchar(320) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `channel`
--
ALTER TABLE `channel`
  ADD PRIMARY KEY (`channel_name`),
  ADD UNIQUE KEY `channel_name_UNIQUE` (`channel_name`),
  ADD UNIQUE KEY `gmail_address_UNIQUE` (`gmail_address`);

--
-- Indexes for table `library`
--
ALTER TABLE `library`
  ADD PRIMARY KEY (`library_id`),
  ADD UNIQUE KEY `library_id_UNIQUE` (`library_id`),
  ADD KEY `gmail_address` (`gmail_address`) USING BTREE;

--
-- Indexes for table `record_in`
--
ALTER TABLE `record_in`
  ADD PRIMARY KEY (`library_id`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD UNIQUE KEY `report_id_UNIQUE` (`report_id`),
  ADD KEY `gmail_address` (`gmail_address`) USING BTREE;

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`),
  ADD UNIQUE KEY `video_id_UNIQUE` (`video_id`),
  ADD UNIQUE KEY `title_UNIQUE` (`title`),
  ADD KEY `channel_name` (`channel_name`) USING BTREE;

--
-- Indexes for table `youtube_user`
--
ALTER TABLE `youtube_user`
  ADD PRIMARY KEY (`gmail_address`),
  ADD UNIQUE KEY `gmail_address_UNIQUE` (`gmail_address`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `channel`
--
ALTER TABLE `channel`
  ADD CONSTRAINT `gmail_address_channel` FOREIGN KEY (`gmail_address`) REFERENCES `youtube_user` (`gmail_address`);

--
-- Constraints for table `library`
--
ALTER TABLE `library`
  ADD CONSTRAINT `library_user` FOREIGN KEY (`gmail_address`) REFERENCES `youtube_user` (`gmail_address`);

--
-- Constraints for table `record_in`
--
ALTER TABLE `record_in`
  ADD CONSTRAINT `record_in_library` FOREIGN KEY (`library_id`) REFERENCES `library` (`library_id`),
  ADD CONSTRAINT `record_in_video` FOREIGN KEY (`video_id`) REFERENCES `video` (`video_id`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `gmail_address_report` FOREIGN KEY (`gmail_address`) REFERENCES `youtube_user` (`gmail_address`);

--
-- Constraints for table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `channel_name` FOREIGN KEY (`channel_name`) REFERENCES `channel` (`channel_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
