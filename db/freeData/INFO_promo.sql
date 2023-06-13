-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 05 juin 2023 à 10:51
-- Version du serveur : 10.4.24-MariaDB
-- Version de PHP : 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `learnagement`
--

--
-- Déchargement des données de la table `INFO_promo`
--

INSERT INTO `INFO_promo` (`id_promo`, `nom_filiere`, `annee`, `parcour`, `semestre`, `site`, `nbGroupeCM`, `nbGroupeTD`, `nbGroupeTP`) VALUES
(2, 'ELEC', 3, '', NULL, 'Campus EST', 1, 1, 2),
(5, 'INFO', 3, '', NULL, 'Campus EST', 1, 1, 2),
(6, 'MECA', 3, '', NULL, 'Campus EST', 1, 3, 6),
(7, 'ECOLO', 3, '', NULL, 'Campus NORD', 1, 1, 2),
(8, 'BATE', 3, '', NULL, 'Campus NORD', 1, 2, 4),
(9, 'BATA', 3, '', NULL, 'Campus NORD', 1, 1, 2),
(10, 'PROD-GI', 0, '', NULL, 'Campus EST', 1, 0, 0),
(11, 'PROD-CM', 0, '', NULL, 'Campus EST', 1, 0, 0),
(12, 'PEIP_A', 1, '', NULL, 'Campus EST', 1, 2, 4),
(13, 'ELEC', 4, '', NULL, 'Campus EST', 1, 2, 3),
(14, 'ELEC', 5, '', NULL, 'Campus EST', 1, 1, 1),
(15, 'INFO', 4, '', NULL, 'Campus EST', 1, 1, 2),
(16, 'INFO', 5, '', NULL, 'Campus EST', 1, 1, 2),
(17, 'MECA', 4, '', NULL, 'Campus EST', 1, 0, 0),
(18, 'PEIP_A', 2, '', NULL, 'Campus EST', 1, 2, 4),
(19, 'PEIP_A', 1, '', NULL, 'Campus NORD', 1, 2, 4),
(20, 'PEIP_A', 2, '', NULL, 'Campus NORD', 1, 2, 4),
(119, NULL, 0, '', NULL, '', 0, 0, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
