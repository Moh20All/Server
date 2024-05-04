-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 04 mai 2024 à 02:32
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `assurance`
--

-- --------------------------------------------------------

--
-- Structure de la table `assure`
--

CREATE TABLE `assure` (
  `ass_id` varchar(10) NOT NULL,
  `nom_ass` varchar(20) NOT NULL,
  `prenom_ass` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(18) NOT NULL,
  `adress` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `assure`
--

INSERT INTO `assure` (`ass_id`, `nom_ass`, `prenom_ass`, `email`, `password`, `adress`) VALUES
('5478291032', 'Allali', 'Mohamed', 'allalimohabaha@gmail.com', 'allali2004', 'Rue Sidi Nadji sidi okba');

-- --------------------------------------------------------

--
-- Structure de la table `assure_compte`
--

CREATE TABLE `assure_compte` (
  `user_id` varchar(5) NOT NULL,
  `ass_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `assure_compte`
--

INSERT INTO `assure_compte` (`user_id`, `ass_id`) VALUES
('TF45S', '5478291032');

-- --------------------------------------------------------

--
-- Structure de la table `assure_contrat`
--

CREATE TABLE `assure_contrat` (
  `ass_id` varchar(10) NOT NULL,
  `contrat_id` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `assure_contrat`
--

INSERT INTO `assure_contrat` (`ass_id`, `contrat_id`) VALUES
('5478291032', '00000001');

-- --------------------------------------------------------

--
-- Structure de la table `car`
--

CREATE TABLE `car` (
  `car_id` varchar(10) NOT NULL,
  `marque` varchar(10) NOT NULL,
  `type` varchar(7) NOT NULL,
  `energie` varchar(7) NOT NULL,
  `model` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `car`
--

INSERT INTO `car` (`car_id`, `marque`, `type`, `energie`, `model`) VALUES
('0012330040', 'daewoo', 'fourgon', 'diesel', 'lublin3');

-- --------------------------------------------------------

--
-- Structure de la table `contrat`
--

CREATE TABLE `contrat` (
  `contrat_id` varchar(8) NOT NULL,
  `n_contrat` int(11) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `carte_grise` varchar(10) NOT NULL,
  `permis` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `contrat`
--

INSERT INTO `contrat` (`contrat_id`, `n_contrat`, `date_debut`, `date_fin`, `carte_grise`, `permis`) VALUES
('00000001', 4463984, '2024-02-21', '2024-08-21', '0012330040', 'L00957444');

-- --------------------------------------------------------

--
-- Structure de la table `contrat_cars`
--

CREATE TABLE `contrat_cars` (
  `contrat_id` varchar(10) NOT NULL,
  `car_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `contrat_cars`
--

INSERT INTO `contrat_cars` (`contrat_id`, `car_id`) VALUES
('00000001', '0012330040');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(5) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`, `FirstName`, `LastName`, `DateOfBirth`) VALUES
('D45FQ', 'allalimohabaha@gmail.com', 'admin', NULL, NULL, NULL),
('TF45S', 'admin@admin.com', 'allali2004', 'Moha', 'Allali', NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `assure`
--
ALTER TABLE `assure`
  ADD PRIMARY KEY (`ass_id`);

--
-- Index pour la table `assure_compte`
--
ALTER TABLE `assure_compte`
  ADD KEY `ncompte` (`ass_id`),
  ADD KEY `test` (`user_id`);

--
-- Index pour la table `assure_contrat`
--
ALTER TABLE `assure_contrat`
  ADD KEY `assured` (`ass_id`),
  ADD KEY `assurance` (`contrat_id`);

--
-- Index pour la table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`car_id`);

--
-- Index pour la table `contrat`
--
ALTER TABLE `contrat`
  ADD PRIMARY KEY (`contrat_id`);

--
-- Index pour la table `contrat_cars`
--
ALTER TABLE `contrat_cars`
  ADD KEY `car` (`car_id`),
  ADD KEY `contrat` (`contrat_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `assure_compte`
--
ALTER TABLE `assure_compte`
  ADD CONSTRAINT `ncompte` FOREIGN KEY (`ass_id`) REFERENCES `assure` (`ass_id`),
  ADD CONSTRAINT `test` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Contraintes pour la table `assure_contrat`
--
ALTER TABLE `assure_contrat`
  ADD CONSTRAINT `assurance` FOREIGN KEY (`contrat_id`) REFERENCES `contrat` (`contrat_id`),
  ADD CONSTRAINT `assured` FOREIGN KEY (`ass_id`) REFERENCES `assure` (`ass_id`);

--
-- Contraintes pour la table `contrat_cars`
--
ALTER TABLE `contrat_cars`
  ADD CONSTRAINT `car` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`),
  ADD CONSTRAINT `contrat` FOREIGN KEY (`contrat_id`) REFERENCES `contrat` (`contrat_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
