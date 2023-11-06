-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : jeu. 27 avr. 2023 à 22:56
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
CREATE DATABASE IF NOT EXISTS `learnagement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `learnagement`;


-- --------------------------------------------------------
-- Table de base
-- --------------------------------------------------------


-- --------------------------------------------------------

--
-- Structure de la table `INFO_vue_parameters`
--

CREATE TABLE `INFO_vue_parameters` (
  `id_vue_parameters` int(11) NOT NULL,
  `sessionId` varchar(50) NOT NULL,
  `semestre` int(11) DEFAULT NULL,
  `code_module` varchar(10) DEFAULT NULL,
  `enseignant` varchar(25) DEFAULT NULL
);

--
-- Index pour la table `INFO_vue_parameters`
--
ALTER TABLE `INFO_vue_parameters`
  ADD PRIMARY KEY (`id_vue_parameters`),
  ADD UNIQUE KEY `sessionId` (`sessionId`);

--
-- AUTO_INCREMENT pour la table `INFO_vue_parameters`
--
ALTER TABLE `INFO_vue_parameters`
  MODIFY `id_vue_parameters` int(11) NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_enseignant`
--

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
);

--
-- Index pour la table `INFO_enseignant`
--
ALTER TABLE `INFO_enseignant`
  ADD PRIMARY KEY (`id_enseignant`),
  ADD UNIQUE KEY `mail` (`mail`),
  ADD UNIQUE KEY `SECONDARY` (`nom`,`prenom`) USING BTREE;

--
-- AUTO_INCREMENT pour la table `INFO_enseignant`
--
ALTER TABLE `INFO_enseignant`
  MODIFY `id_enseignant` int(11) NOT NULL AUTO_INCREMENT;


-- --------------------------------------------------------

--
-- Structure de la table `INFO_filiere`
--

CREATE TABLE `INFO_filiere` (
  `nom_filiere` varchar(11) NOT NULL,
  `nom_long` varchar(50) DEFAULT NULL
);

--
-- Index pour la table `INFO_filiere`
--
ALTER TABLE `INFO_filiere`
  ADD PRIMARY KEY (`nom_filiere`);


-- --------------------------------------------------------

--
-- Structure de la table `INFO_module`
--

CREATE TABLE `INFO_module` (
  `id_module` int(11) NOT NULL,
  `code_module` varchar(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `semestre` int(11) NOT NULL,
  `hCM` float DEFAULT NULL,
  `hTD` float DEFAULT NULL,
  `hTP` float DEFAULT NULL,
  `hTPTD` float DEFAULT NULL,
  `type` ENUM('Specialite','Transverse') DEFAULT 'Specialité',
  `id_enseignant` int(11) DEFAULT NULL,
  `commentaire` text DEFAULT NULL
);

--
-- Index pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  ADD PRIMARY KEY (`id_module`),
  ADD UNIQUE KEY `SECONDARY` (`code_module`) USING BTREE,
  ADD KEY `id_responsable` (`id_enseignant`);

--
-- AUTO_INCREMENT pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  MODIFY `id_module` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  ADD CONSTRAINT `FK_enseignant` FOREIGN KEY (`id_enseignant`) REFERENCES `INFO_enseignant` (`id_enseignant`);



-- --------------------------------------------------------

--
-- Structure de la table `INFO_promo`
--

CREATE TABLE `INFO_promo` (
  `id_promo` int(11) NOT NULL,
  `nom_filiere` varchar(11) NOT NULL,
  `statut` ENUM('FISE', 'FISA', 'FISEA', 'FISECP') DEFAULT 'FISE',
  `annee` int(11) NOT NULL,
  `parcour` varchar(25) DEFAULT NULL,
  `site` varchar(25) NOT NULL,
  `nbGroupeCM` int(11) NOT NULL DEFAULT 1,
  `nbGroupeTD` int(11) NOT NULL,
  `nbGroupeTP` int(11) NOT NULL
);

--
-- Index pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  ADD PRIMARY KEY (`id_promo`),
  ADD UNIQUE KEY `SECONDARY` (`nom_filiere`,`annee`,`site`,`parcour`) USING BTREE;

--
-- AUTO_INCREMENT pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  MODIFY `id_promo` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  ADD CONSTRAINT `FK_filiere` FOREIGN KEY (`nom_filiere`) REFERENCES `INFO_filiere` (`nom_filiere`);

-- --------------------------------------------------------

--
-- Structure de la table `INFO_CMTDTP`
--

CREATE TABLE `INFO_CMTDTP` (
  `id_CMTDTP` int(11) NOT NULL,
  `lieu` varchar(25) NOT NULL,
  `type` varchar(10) NOT NULL,
  `heure` float NOT NULL,
  `id_enseignant` int(11) DEFAULT NULL,
  `id_module` int(11) NOT NULL
);

--
-- Index pour la table `INFO_CMTDTP`
--
ALTER TABLE `INFO_CMTDTP`
  ADD PRIMARY KEY (`id_CMTDTP`),
  ADD KEY `FK_module_CMTDTP` (`id_module`),
  ADD KEY `FK_enseignant_CMTDTP` (`id_enseignant`);

--
-- AUTO_INCREMENT pour la table `INFO_CMTDTP`
--
ALTER TABLE `INFO_CMTDTP`
  MODIFY `id_CMTDTP` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour la table `INFO_CMTDTP`
--
ALTER TABLE `INFO_CMTDTP`
  ADD CONSTRAINT `FK_enseignant_CMTDTP` FOREIGN KEY (`id_enseignant`) REFERENCES `INFO_enseignant` (`id_enseignant`),
  ADD CONSTRAINT `FK_module_CMTDTP` FOREIGN KEY (`id_module`) REFERENCES `INFO_module` (`id_module`);


-- --------------------------------------------------------

--
-- Structure de la table `INFO_seanceType`
--

CREATE TABLE `INFO_seanceType` (
  `type` varchar(10) NOT NULL,
  `commentaire` varchar(50) NOT NULL
);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `INFO_seanceType`
--
ALTER TABLE `INFO_seanceType`
  ADD PRIMARY KEY (`type`);



-- --------------------------------------------------------

--
-- Structure de la table `INFO_seance`
--

CREATE TABLE `INFO_seance` (
  `id_seance` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `date` datetime NOT NULL,
  `duree` time NOT NULL,
  `id_module` int(11) NOT NULL,
  `id_enseignant` int(11) NOT NULL
);

--
-- Index pour la table `INFO_seance`
--
ALTER TABLE `INFO_seance`
  ADD PRIMARY KEY (`id_seance`),
  ADD UNIQUE KEY `date` (`date`,`id_enseignant`);

--
-- AUTO_INCREMENT pour la table `INFO_seance`
--
ALTER TABLE `INFO_seance`
  MODIFY `id_seance` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour la table  `INFO_seance`
--
ALTER TABLE  `INFO_seance`
  ADD CONSTRAINT `FK_seance_seanceType` FOREIGN KEY (`type`) REFERENCES `INFO_seanceType` (`type`);



-- --------------------------------------------------------
-- Tables de liasons
-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Structure de la table `INFO_dependances`
--

CREATE TABLE `INFO_dependances` (
  `id_dependances` int NOT NULL,
  `id_module precedant` int NOT NULL,
  `type precedant` varchar(10)  NOT NULL,
  `numero seance precedant` int NOT NULL,
  `id_module suivant` int NOT NULL,
  `type suivant` varchar(10) NOT NULL,
  `numero seance suivant` int NOT NULL
);

--
-- Index pour la table `INFO_dependances`
--
ALTER TABLE `INFO_dependances`
  ADD PRIMARY KEY (`id_dependances`),
  ADD KEY `FK_dependances_as_module_prev` (`id_module precedant`),
  ADD KEY `FK_dependances_as_module_next` (`id_module suivant`),
  ADD KEY `FK_dependances_as_seanceType_prev` (`type precedant`),
  ADD KEY `FK_dependances_as_seanceType_next` (`type suivant`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `INFO_dependances`
--
ALTER TABLE `INFO_dependances`
  ADD CONSTRAINT `FK_dependances_as_module_next` FOREIGN KEY (`id_module suivant`) REFERENCES `INFO_module` (`id_module`),
  ADD CONSTRAINT `FK_dependances_as_module_prev` FOREIGN KEY (`id_module precedant`) REFERENCES `INFO_module` (`id_module`),
  ADD CONSTRAINT `FK_dependances_as_seanceType_next` FOREIGN KEY (`type suivant`) REFERENCES `INFO_seanceType` (`type`),
  ADD CONSTRAINT `FK_dependances_as_seanceType_prev` FOREIGN KEY (`type precedant`) REFERENCES `INFO_seanceType` (`type`);


-- --------------------------------------------------------

--
-- Structure de la table `INFO_module_as_promo`
--

CREATE TABLE `INFO_module_as_promo` (
  `id_module` int(11) NOT NULL,
  `id_promo` int(11) NOT NULL
);

--
-- Index pour la table `INFO_module_as_promo`
--
ALTER TABLE `INFO_module_as_promo`
  ADD PRIMARY KEY (`id_module`,`id_promo`);

--
-- Contraintes pour la table `INFO_module_as_promo`
--
ALTER TABLE `INFO_module_as_promo`
  ADD CONSTRAINT `FK_module` FOREIGN KEY (`id_module`) REFERENCES `INFO_module` (`id_module`),
  ADD CONSTRAINT `FK_promo` FOREIGN KEY (`id_promo`) REFERENCES `INFO_promo` (`id_promo`);
  
-- --------------------------------------------------------

--
-- Structure de la table `INFO_CMTDTP_as_promo`
--

CREATE TABLE `INFO_CMTDTP_as_promo` (
  `id_CMTDTP` int(11) NOT NULL,
  `id_promo` int(11) NOT NULL
);

--
-- Index pour la table `INFO_CMTDTP_as_promo`
--
ALTER TABLE `INFO_CMTDTP_as_promo`
  ADD PRIMARY KEY (`id_CMTDTP`,`id_promo`);

--
-- Contraintes pour la table `INFO_CMTDTP_as_promo`
--
ALTER TABLE `INFO_CMTDTP_as_promo`
  ADD CONSTRAINT `INFO_CMTDTP_as_promo_ibfk_1` FOREIGN KEY (`id_CMTDTP`) REFERENCES `INFO_CMTDTP` (`id_CMTDTP`),
  ADD CONSTRAINT `INFO_CMTDTP_as_promo_ibfk_2` FOREIGN KEY (`id_promo`) REFERENCES `INFO_promo` (`id_promo`);



-- --------------------------------------------------------

--
-- Structure de la table `INFO_dependances_CMTDTP`
--

CREATE TABLE `INFO_dependances_CMTDTP` (
  `precedent` int(11) NOT NULL,
  `successeur` int(11) NOT NULL
);

--
-- Index pour la table `INFO_dependances_CMTDTP`
--
ALTER TABLE `INFO_dependances_CMTDTP`
  ADD PRIMARY KEY (`precedent`,`successeur`);



-- --------------------------------------------------------

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
