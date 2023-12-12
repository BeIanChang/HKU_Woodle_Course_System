-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 17, 2020 at 09:41 PM
-- Server version: 5.7.28-0ubuntu0.18.04.4
-- PHP Version: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+08:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `facerecognition`
-- Command: mysql -u root -p
-- Command: use facerecognition
-- Command: source facerecognition.sql
-- Table: Users, Students, Teachers, Courses, Coursetimeslots, Registercourses

-- --------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- Table structure for table `Users`
--
DROP TABLE IF EXISTS `Users`;

# Create TABLE 'Users'
CREATE TABLE `Users` (
  `user_id` int AUTO_INCREMENT PRIMARY KEY,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(200) NOT NULL,
  `user_login_time` time NOT NULL,
  `user_login_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1, "JACK", "jack@gmail.com", NOW(), '15-11-2023');
INSERT INTO `Users` VALUES (2, "TOM", "tom@gmail.com", NOW(), '15-11-2023');
INSERT INTO `Users` VALUES (3, "Prof. Smith", "p.smith@gmail.com", NOW(), '15-11-2023');
INSERT INTO `Users` VALUES (4, "Prof. Wong", "p.wong@gmail.com", NOW(), '15-11-2023');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

------------------------------------------------------------------------------------------------------
-- Table structure for table `Students`
--
DROP TABLE IF EXISTS `Students`;

# Create TABLE 'Students'
CREATE TABLE `Students` (
  `user_id` INT PRIMARY KEY,
  `student_id_string` varchar(50) NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES Users(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Students` VALUES (1, "Y123456");
INSERT INTO `Students` VALUES (2, "B123456");
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

------------------------------------------------------------------------------------------------------
-- Table structure for table `Teachers`
--
DROP TABLE IF EXISTS `Teachers`;

# Create TABLE 'Teachers'
CREATE TABLE `Teachers` (
  `user_id` INT PRIMARY KEY,
  `teacher_office` varchar(50) NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES Users(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Teachers` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Teachers` VALUES (3, "KB217");
INSERT INTO `Teachers` VALUES (4, "CYM111");
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;


------------------------------------------------------------------------------------------------------
-- Table structure for table `Courses` 
--
DROP TABLE IF EXISTS `Courses`;

# Create TABLE 'Courses'
CREATE TABLE `Courses` (
  `course_id` int AUTO_INCREMENT PRIMARY KEY,
  `course_code` varchar(50) NOT NULL,
  `course_name` varchar(200) NOT NULL,
  `teacher_user_id` int not NULL,
  `teacher_message` varchar(200) NOT NULL,
  `zoom_link` varchar(200) NOT NULL,
  `lecture_note` varchar(200) NOT NULL,
  FOREIGN KEY (`teacher_user_id`) REFERENCES Teachers(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Courses` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Courses` VALUES (1, "COMP2120", "Computer Organization", 3, "Computer Organization is fun as long as you attend lecture. Welcome back.", "https://hku.zoom.us/j/98307568693?pwd=QmlqZERWeDdWRVZ3SGdqWG51YUtndz09", "https://moodle.hku.hk/mod/resource/view.php?id=3168903");
INSERT INTO `Courses` VALUES (2, "COMP3278", "Introduction to database management systems", 4, "Hi everyone! Welcome to COMP3278! Let expolore database together.", "www.zoom.com/3278", "3278note.pdf");
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

------------------------------------------------------------------------------------------------------
-- Table structure for table `Coursetimeslots` 
--
DROP TABLE IF EXISTS `Coursetimeslots`;

# Create TABLE 'Coursetimeslots'
CREATE TABLE `Coursetimeslots` (
  `course_id` int,
  `start_time` varchar(100) NOT NULL,
  `end_time` varchar(100) NOT NULL,
  `day_in_week` varchar(50) NOT NULL,
  `course_venue` varchar(50) NOT NULL,
  FOREIGN KEY (`course_id`) REFERENCES Courses(`course_id`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Coursetimeslots` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Coursetimeslots` VALUES (1, "11:00", "12:00", "2", "CYM112");
INSERT INTO `Coursetimeslots` VALUES (1, "11:00", "13:00", "4", "CYM112");
INSERT INTO `Coursetimeslots` VALUES (2, "14:00", "16:00", "1", "CYM212");
INSERT INTO `Coursetimeslots` VALUES (2, "14:00", "15:00", "5", "CYM212");
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

------------------------------------------------------------------------------------------------------
-- Table structure for table `Registercourses` 
--
DROP TABLE IF EXISTS `Registercourses`;

# Create TABLE 'Registercourses'
CREATE TABLE `Registercourses` (
  `user_id` int,
  `course_id` int,
  FOREIGN KEY (`course_id`) REFERENCES Courses(`course_id`),
  FOREIGN KEY (`user_id`) REFERENCES Students(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Registercourses` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Registercourses` VALUES (1,1);
INSERT INTO `Registercourses` VALUES (1,2);
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

------------------------------------------------------------------------------------------------------
-- Table structure for table `Teachesecourse` 
--
DROP TABLE IF EXISTS `Teachesecourse`;

# Create TABLE 'Teachesecourse'
CREATE TABLE `Teachesecourse` (
  `user_id` int,
  `course_id` int,
  FOREIGN KEY (`course_id`) REFERENCES Courses(`course_id`),
  FOREIGN KEY (`user_id`) REFERENCES Teachers(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Teachesecourse` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Teachesecourse` VALUES (3,1);
INSERT INTO `Teachesecourse` VALUES (4,2);
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;



-- # Ben: Create TABLE 'Teahes' optional




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
