-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 26 mai 2023 à 16:51
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

-- --------------------------------------------------------

--
-- Structure de la table `INFO_enseignant`
--
/*
CREATE TABLE `INFO_enseignant` (
  `id_enseignant` int(11) NOT NULL,
  `prenom` varchar(25) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `mail` varchar(25) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `statut` varchar(25) NOT NULL DEFAULT 'permanant',
  `composante` varchar(25) DEFAULT NULL,
  `service statutaire` int(11) NOT NULL,
  `décharge` int(11) NOT NULL,
  `service effectif` float NOT NULL DEFAULT 192,
  `HCAutorisees` tinyint(1) NOT NULL DEFAULT 1,
  `commentaire` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/
--
-- Déchargement des données de la table `INFO_enseignant`
--

INSERT INTO `INFO_enseignant` (`id_enseignant`, `prenom`, `nom`, `mail`, `password`, `statut`, `composante`, `service statutaire`, `décharge`, `service effectif`, `HCAutorisees`, `commentaire`) VALUES
(6, 'MICKAEL', 'BOISNE-NOC', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(7, 'ANNE', 'ALLAIN', NULL, NULL, 'DCE', NULL, 192, 0, 192, 1, NULL),
(8, 'JEROME', 'VALET', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(9, 'CYRILLE', 'DARY', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(10, 'CLARA', 'OTHONIEL', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(11, 'JEROME', 'VIDALIE', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(12, 'RAPHAEL', 'DENIS', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(13, 'JEROME', 'RE', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(14, 'ARMEL', 'DESRUES', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(15, 'VINCENT', 'JUNG', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(16, 'NICOLAS', 'VIOLET', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(17, 'FABRICE', 'ALMERAS', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(18, 'NICOLAS', 'TARDIEU', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(19, 'YANNICK', 'PAILLET', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(23, 'LAURENCE', 'BESNOUIN', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(24, 'NICOLAS', 'POIRAUD', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(25, 'STEPHANIE', 'SCHERMESSER', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(26, 'SEVERINE', 'PLESSIS', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(28, 'SYLVAIN', 'CLAVEL', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(29, 'FABIEN', 'VIARD', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(30, 'OLIVIER', 'CUISNIER', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(32, 'CYRIL', 'MONTAGNE', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(33, 'FREDERIC', 'MARCHAL', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(34, 'SABRINA', 'BRETONNIER', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(36, 'FABRICE', 'BALMER', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(37, 'MICKAEL', 'PETIT', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(38, 'CLOTILDE', 'D\'ELBOEUF', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(39, 'ADELINE', 'BOULLE', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(41, 'JULIE', 'SAHUC', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(42, 'AUDREY', 'HENRIOUD', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(43, 'CHRISTELLE', 'ROUX', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(44, 'PABLO', 'TEDESCO', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(45, 'ROMAIN', 'TROUILLET', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(46, 'SOPHIE', 'MAHIAS', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(47, 'JEAN-MARC', 'VILLENEUVE', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(49, 'MARC', 'FRANCILLON', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(51, 'MYRIAM', 'THUET', NULL, NULL, 'permanant', NULL, 192, 0, 192, 1, NULL),
(52, 'CECILE', 'PICHARD', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL),
(53, 'LAURENT', 'TEPPOZ', NULL, NULL, 'vacataire', NULL, 192, 0, 192, 1, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
