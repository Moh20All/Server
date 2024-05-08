-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 08, 2024 at 02:04 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assurance`
--

-- --------------------------------------------------------

--
-- Table structure for table `assure`
--

DROP TABLE IF EXISTS `assure`;
CREATE TABLE IF NOT EXISTS `assure` (
  `ass_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `nom_ass` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `prenom_ass` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(18) COLLATE utf8mb4_general_ci NOT NULL,
  `adress` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ass_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assure`
--

INSERT INTO `assure` (`ass_id`, `nom_ass`, `prenom_ass`, `email`, `password`, `adress`) VALUES
('5478291032', 'Allali', 'Mohamed', 'allalimohabaha@gmail.com', 'allali2004', 'Rue Sidi Nadji sidi okba');

-- --------------------------------------------------------

--
-- Table structure for table `assure_compte`
--

DROP TABLE IF EXISTS `assure_compte`;
CREATE TABLE IF NOT EXISTS `assure_compte` (
  `user_id` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `ass_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  KEY `ncompte` (`ass_id`),
  KEY `test` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assure_compte`
--

INSERT INTO `assure_compte` (`user_id`, `ass_id`) VALUES
('TF45S', '5478291032');

-- --------------------------------------------------------

--
-- Table structure for table `assure_contrat`
--

DROP TABLE IF EXISTS `assure_contrat`;
CREATE TABLE IF NOT EXISTS `assure_contrat` (
  `ass_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `contrat_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  KEY `assured` (`ass_id`),
  KEY `assurance` (`contrat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assure_contrat`
--

INSERT INTO `assure_contrat` (`ass_id`, `contrat_id`) VALUES
('5478291032', '00000001'),
('5478291032', '00000002');

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
CREATE TABLE IF NOT EXISTS `car` (
  `car_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `marque` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(7) COLLATE utf8mb4_general_ci NOT NULL,
  `energie` varchar(7) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(7) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`car_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`car_id`, `marque`, `type`, `energie`, `model`) VALUES
('0012330040', 'daewoo', 'fourgon', 'diesel', 'lublin3'),
('0012430040', 'renault', 'car', 'diesel', 'megane2');

-- --------------------------------------------------------

--
-- Table structure for table `contrat`
--

DROP TABLE IF EXISTS `contrat`;
CREATE TABLE IF NOT EXISTS `contrat` (
  `contrat_id` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  `n_contrat` int NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `carte_grise` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `permis` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`contrat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contrat`
--

INSERT INTO `contrat` (`contrat_id`, `n_contrat`, `date_debut`, `date_fin`, `carte_grise`, `permis`) VALUES
('00000001', 4463984, '2024-02-21', '2024-08-21', '0012330040', 'L00957444'),
('00000002', 4461984, '2024-02-21', '2024-08-21', '0012331240', 'L00957444');

-- --------------------------------------------------------

--
-- Table structure for table `contrat_cars`
--

DROP TABLE IF EXISTS `contrat_cars`;
CREATE TABLE IF NOT EXISTS `contrat_cars` (
  `contrat_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `car_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  KEY `car` (`car_id`),
  KEY `contrat` (`contrat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contrat_cars`
--

INSERT INTO `contrat_cars` (`contrat_id`, `car_id`) VALUES
('00000001', '0012330040'),
('00000002', '0012430040');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
CREATE TABLE IF NOT EXISTS `requests` (
  `id` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `name` text COLLATE utf8mb4_general_ci NOT NULL,
  `type` int NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `name`, `type`, `status`) VALUES
('TF45S', 'Allali mohamed baha eddine', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`) VALUES
('D45FQ', 'allalimohabaha@gmail.com', 'admin'),
('TF45S', 'admin@admin.com', 'allali2004');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assure_compte`
--
ALTER TABLE `assure_compte`
  ADD CONSTRAINT `ncompte` FOREIGN KEY (`ass_id`) REFERENCES `assure` (`ass_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `test` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `assure_contrat`
--
ALTER TABLE `assure_contrat`
  ADD CONSTRAINT `assurance` FOREIGN KEY (`contrat_id`) REFERENCES `contrat` (`contrat_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `assured` FOREIGN KEY (`ass_id`) REFERENCES `assure` (`ass_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `contrat_cars`
--
ALTER TABLE `contrat_cars`
  ADD CONSTRAINT `car` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `contrat` FOREIGN KEY (`contrat_id`) REFERENCES `contrat` (`contrat_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
