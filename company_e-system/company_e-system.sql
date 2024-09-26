-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 01, 2023 at 08:31 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `company_e-system`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `delete_correspondence`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_correspondence` (`del_correspondence` INT)  BEGIN
DELETE FROM correspondence WHERE correspondence_id=del_correspondence;
END$$

DROP PROCEDURE IF EXISTS `delete_pay`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_pay` (`del_pay` INT)  BEGIN
DELETE FROM pay WHERE pay_id=del_pay;
END$$

DROP PROCEDURE IF EXISTS `delete_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user` (`del_user` INT)  BEGIN
DELETE FROM users WHERE users_id=del_user;
END$$

DROP PROCEDURE IF EXISTS `delete_user_contract`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_contract` (`uc_id` INT)  BEGIN
DELETE FROM user_contract WHERE user_contract_id = uc_id;
END$$

DROP PROCEDURE IF EXISTS `insert_correspondence`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_correspondence` (`send_d` DATE, `msg` TEXT(1000), `read_` BIT, `msg_f` INT, `msg_t` INT)  BEGIN
INSERT INTO correspondence(send_date, message, `read`, message_from, message_to) VALUES (send_d , msg , read_ , msg_f , msg_t  );
END$$

DROP PROCEDURE IF EXISTS `insert_pay`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pay` (`date_` DATE, `salary_p` BIT, `uc_id` INT)  BEGIN
INSERT INTO pay(`date`, salary_paid, user_contract_id) VALUES (date_, salary_p, uc_id);
END$$

DROP PROCEDURE IF EXISTS `insert_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_user` (`f_name` VARCHAR(45), `l_name` VARCHAR(45), `date_of_b` DATE, `@e-m` VARCHAR(100), `usern` VARCHAR(100))  BEGIN
INSERT INTO users(first_name, last_name, date_of_birth, `e-mail`, username) VALUES (f_name , l_name , date_of_b , `@e-m` , usern);
END$$

DROP PROCEDURE IF EXISTS `insert_user_contract`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_user_contract` (`userid` INT, `salary_` DECIMAL(10,4), `contract_` VARCHAR(45))  BEGIN
INSERT INTO user_contract(user_id, salary, contract) VALUES (userid, salary_, contract_);
END$$

DROP PROCEDURE IF EXISTS `update_correspondence`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_correspondence` (`correspondenceid` INT, `send_d` DATE, `msg` TEXT(1000), `read_` BIT, `message_f` INT, `message_t` INT)  BEGIN
UPDATE correspondence SET send_date = send_d, message = msg, `read`= read_, message_from = message_f, message_to = message_t   WHERE correspondence_id = correspondenceid;
END$$

DROP PROCEDURE IF EXISTS `update_pay`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pay` (`payid` INT, `date_` DATE, `salary_p` BIT, `uc_id` INT)  BEGIN
UPDATE pay SET `date` = date_, salary_paid = salary_p, user_contract_id = uc_id WHERE pay_id = payid;
END$$

DROP PROCEDURE IF EXISTS `update_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user` (`userid` INT, `f_name` VARCHAR(45), `l_name` VARCHAR(45), `date_of_b` DATE, `e-m` VARCHAR(100), `usern` VARCHAR(100))  BEGIN
UPDATE users SET first_name = f_name, last_name = l_name, date_of_birth = date_of_b, `e-mail` = `e-m`, username = usern WHERE users_id = userid;
END$$

DROP PROCEDURE IF EXISTS `update_user_bio_photo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_bio_photo` (`userid` INT, `bio_` TEXT(1000), `photo_` BLOB)  BEGIN
UPDATE users SET bio = bio_, photo = photo_ WHERE users_id = userid;
END$$

DROP PROCEDURE IF EXISTS `update_user_contract`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_contract` (`uc_id` INT, `userid` INT, `salary_` DECIMAL(10,4), `contract_` VARCHAR(45))  BEGIN
UPDATE user_contract SET user_id =userid, salary = salary_, contract = contract_ WHERE user_contract_id = uc_id;
END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `user_msg_number`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `user_msg_number` (`number` INT) RETURNS INT(11) BEGIN
DECLARE result int;
SELECT COUNT(message_from) FROM correspondence WHERE message_from = `number` INTO result;
RETURN result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `basic_info`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `basic_info`;
CREATE TABLE IF NOT EXISTS `basic_info` (
`first_name` varchar(45)
,`last_name` varchar(45)
,`date_of_birth` date
);

-- --------------------------------------------------------

--
-- Table structure for table `correspondence`
--

DROP TABLE IF EXISTS `correspondence`;
CREATE TABLE IF NOT EXISTS `correspondence` (
  `correspondence_id` int(11) NOT NULL AUTO_INCREMENT,
  `send_date` date NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `read` bit(1) NOT NULL,
  `message_from` int(11) NOT NULL,
  `message_to` int(11) NOT NULL,
  PRIMARY KEY (`correspondence_id`),
  KEY `fk_message_from_idx` (`message_from`),
  KEY `fk_message_to_idx` (`message_to`),
  KEY `IDX_SEND_DATE` (`send_date`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `correspondence`
--

INSERT INTO `correspondence` (`correspondence_id`, `send_date`, `message`, `read`, `message_from`, `message_to`) VALUES
(3, '2022-11-15', 'Pozdrav burazeru, kad se vracas iz Nemacke? Kako ti je tamo?', b'1', 1, 3),
(7, '2022-11-21', 'Vracam se sredinom decembra. Ovde je extra, sve je jeftinije nego kod nas, jedino su cigare skuplje.. Vi kako ste? sta ima novo?', b'1', 3, 1),
(10, '2022-11-22', 'Dobro smo, pozdravlja te keva puno. Nista nisi propustio, sve po starom, jedino godine prolaze :D', b'0', 1, 3),
(11, '2022-12-16', 'Slecem u Bg za pola sata.', b'1', 3, 1),
(12, '2022-10-06', 'Malo cu da zakasnim, skuvaj mi kafu ako ti nije tesko.', b'1', 5, 6),
(13, '2022-10-06', 'Ok.', b'1', 6, 5),
(14, '2022-11-03', 'Malo kasnim, zapocni moj proces.', b'1', 5, 6),
(15, '2022-11-03', 'Stalno kasnis, ovo je zadnji put da radim tvoj poso!', b'1', 6, 5),
(17, '2022-12-16', 'Acojneru, sta ces da nosis na proslavu?', b'1', 4, 1),
(18, '2022-12-16', 'Planirao sam crne pantalone i plavu kosulju.. Ti?', b'1', 1, 4),
(19, '2022-12-16', 'Ja cu ceo bude u plavo verovatno.', b'0', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pay`
--

DROP TABLE IF EXISTS `pay`;
CREATE TABLE IF NOT EXISTS `pay` (
  `pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `salary_paid` bit(1) NOT NULL DEFAULT b'1',
  `user_contract_id` int(11) NOT NULL,
  PRIMARY KEY (`pay_id`),
  KEY `fk_pay_id_idx` (`user_contract_id`),
  KEY `IDX_DATE` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pay`
--

INSERT INTO `pay` (`pay_id`, `date`, `salary_paid`, `user_contract_id`) VALUES
(1, '2022-12-30', b'1', 1),
(2, '2022-12-30', b'1', 4),
(3, '2022-12-30', b'1', 5),
(4, '2022-12-30', b'1', 6),
(5, '2022-12-30', b'1', 7);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `users_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `e-mail` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `bio` text COLLATE utf8_unicode_ci,
  `photo` blob,
  PRIMARY KEY (`users_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `e-mail_UNIQUE` (`e-mail`),
  KEY `IDX_NAME` (`last_name`,`first_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`users_id`, `first_name`, `last_name`, `date_of_birth`, `e-mail`, `username`, `bio`, `photo`) VALUES
(1, 'Aleksandar', 'Veljkovic', '1995-11-27', 'crosshair112@gmail.com', 'Acomir', NULL, NULL),
(3, 'Nenad', 'Veljkovic', '1994-03-10', 'neshica944@gmail.com', 'shone944', NULL, NULL),
(4, 'Dalibor', 'Randjelovic', '1995-12-20', 'dach1995@gmail.com', 'randjalwayer', NULL, NULL),
(5, 'Milena', 'Mitic', '1995-01-15', 'mitickaaa95@gmail.com', 'miticka955', NULL, NULL),
(6, 'Hristina', 'Nikolic', '1995-05-07', 'tinabambina9955@gmail.com', 'tinicaNikolic95', NULL, NULL),
(7, 'Milutin', 'Ivanovic', '1994-04-19', 'kafedzijamicko94@gmail.com', 'milutinIvanovic944', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_contract`
--

DROP TABLE IF EXISTS `user_contract`;
CREATE TABLE IF NOT EXISTS `user_contract` (
  `user_contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `salary` decimal(10,4) UNSIGNED NOT NULL,
  `contract` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'full-time',
  PRIMARY KEY (`user_contract_id`),
  KEY `fk_user_contract_id_idx` (`user_id`),
  KEY `IDX_SALARY` (`salary`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_contract`
--

INSERT INTO `user_contract` (`user_contract_id`, `user_id`, `salary`, `contract`) VALUES
(1, 1, '72000.0000', 'full-time'),
(4, 3, '81000.0000', 'full-time'),
(5, 4, '41000.0000', 'part-time'),
(6, 5, '38000.0000', 'part-time'),
(7, 6, '35000.0000', 'part-time');

-- --------------------------------------------------------

--
-- Structure for view `basic_info`
--
DROP TABLE IF EXISTS `basic_info`;

DROP VIEW IF EXISTS `basic_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `basic_info`  AS SELECT `users`.`first_name` AS `first_name`, `users`.`last_name` AS `last_name`, `users`.`date_of_birth` AS `date_of_birth` FROM `users` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `correspondence`
--
ALTER TABLE `correspondence` ADD FULLTEXT KEY `IDX_MESSAGE` (`message`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `correspondence`
--
ALTER TABLE `correspondence`
  ADD CONSTRAINT `fk_message_from` FOREIGN KEY (`message_from`) REFERENCES `users` (`users_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_message_to` FOREIGN KEY (`message_to`) REFERENCES `users` (`users_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pay`
--
ALTER TABLE `pay`
  ADD CONSTRAINT `fk_pay_id` FOREIGN KEY (`user_contract_id`) REFERENCES `user_contract` (`user_contract_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_contract`
--
ALTER TABLE `user_contract`
  ADD CONSTRAINT `fk_user_contract_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`users_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
