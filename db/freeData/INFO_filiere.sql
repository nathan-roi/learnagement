-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 05 juin 2023 à 16:01
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
-- Structure de la table `INFO_filiere`
--

CREATE TABLE `INFO_filiere` (
  `nom_filiere` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `INFO_filiere`
--

INSERT INTO `INFO_filiere` (`nom_filiere`) VALUES
('BATA'),
('BATE'),
('ECOLO'),
('INFO'),
('MECA'),
('PROD-CM'),
('PROD-GI'),
('PEIP_A'),
('ELEC');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `INFO_filiere`
--
ALTER TABLE `INFO_filiere`
  ADD PRIMARY KEY (`nom_filiere`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
