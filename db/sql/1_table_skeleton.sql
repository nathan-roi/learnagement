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

--
-- Doublure de structure pour la vue `INFO_check_module_as_not_promo`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_check_module_as_not_promo` (
`id_module` int(11)
);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_CMTDTP_as_promo`
--

CREATE TABLE `INFO_CMTDTP_as_promo` (
  `id_CMTDTP` int(11) NOT NULL,
  `id_promo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_dependances_CMTDTP`
--

CREATE TABLE `INFO_dependances_CMTDTP` (
  `precedent` int(11) NOT NULL,
  `successeur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_intervenants`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_intervenants` (
`code` varchar(10)
,`module` varchar(50)
,`lieu` varchar(25)
,`type` varchar(10)
,`heure` float
,`enseignant` varchar(25)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_interventions`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_interventions` (
`code` varchar(10)
,`module` varchar(50)
,`lieu` varchar(25)
,`type` varchar(10)
,`heure` float
,`enseignant` varchar(25)
,`filières` mediumtext
);

-- --------------------------------------------------------

--
-- Structure de la table `INFO_module`
--

CREATE TABLE `INFO_module` (
  `id_module` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `semestre` int(11) NOT NULL,
  `hCM` float DEFAULT NULL,
  `hTD` float DEFAULT NULL,
  `hTP` float DEFAULT NULL,
  `hTPTD` float DEFAULT NULL,
  `filiere` varchar(20) NOT NULL,
  `id_enseignant` int(11) DEFAULT NULL,
  `commentaire` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_module_2_promo_mccc`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_module_2_promo_mccc` (
`code` varchar(10)
,`site` varchar(25)
,`hCMmccc` float
,`hTDmccc` double
,`hTPmccc` double
,`hTPTDmccc` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_module_2_promo_prev`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_module_2_promo_prev` (
`code` varchar(10)
,`site` varchar(25)
,`hCMprev` double
,`hTDprev` double
,`hTPprev` double
,`hTPTDprev` double
);

-- --------------------------------------------------------

--
-- Structure de la table `INFO_module_as_promo`
--

CREATE TABLE `INFO_module_as_promo` (
  `id_module` int(11) NOT NULL,
  `id_promo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_promo`
--

CREATE TABLE `INFO_promo` (
  `id_promo` int(11) NOT NULL,
  `nom_filiere` varchar(8) DEFAULT NULL,
  `annee` int(11) NOT NULL,
  `parcour` varchar(25) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `site` varchar(25) NOT NULL,
  `nbGroupeCM` int(11) NOT NULL DEFAULT 1,
  `nbGroupeTD` int(11) NOT NULL,
  `nbGroupeTP` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_vue_parameters`
--

CREATE TABLE `INFO_vue_parameters` (
  `id` int(11) NOT NULL,
  `sessionId` varchar(50) NOT NULL,
  `semestre` int(11) DEFAULT NULL,
  `module` varchar(10) DEFAULT NULL,
  `enseignant` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `INFO_CMTDTP`
--
ALTER TABLE `INFO_CMTDTP`
  ADD PRIMARY KEY (`id_CMTDTP`),
  ADD KEY `FK_module_CMTDTP` (`id_module`),
  ADD KEY `FK_enseignant_CMTDTP` (`id_enseignant`);

--
-- Index pour la table `INFO_CMTDTP_as_promo`
--
ALTER TABLE `INFO_CMTDTP_as_promo`
  ADD PRIMARY KEY (`id_CMTDTP`,`id_promo`),
  ADD KEY `id_filiere` (`id_promo`);

--
-- Index pour la table `INFO_dependances_CMTDTP`
--
ALTER TABLE `INFO_dependances_CMTDTP`
  ADD PRIMARY KEY (`precedent`,`successeur`);

--
-- Index pour la table `INFO_enseignant`
--
ALTER TABLE `INFO_enseignant`
  ADD PRIMARY KEY (`id_enseignant`),
  ADD UNIQUE KEY `mail` (`mail`),
  ADD UNIQUE KEY `SECONDARY` (`nom`,`prenom`) USING BTREE;

--
-- Index pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  ADD PRIMARY KEY (`id_module`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `id_responsable` (`id_enseignant`);

--
-- Index pour la table `INFO_module_as_promo`
--
ALTER TABLE `INFO_module_as_promo`
  ADD PRIMARY KEY (`id_module`,`id_promo`),
  ADD KEY `FK_promo` (`id_promo`);

--
-- Index pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  ADD PRIMARY KEY (`id_promo`),
  ADD UNIQUE KEY `nom_filiere` (`nom_filiere`,`annee`,`site`,`parcour`) USING BTREE;

--
-- Index pour la table `INFO_seance`
--
ALTER TABLE `INFO_seance`
  ADD PRIMARY KEY (`id_seance`),
  ADD UNIQUE KEY `date` (`date`,`id_enseignant`);

--
-- Index pour la table `INFO_vue_parameters`
--
ALTER TABLE `INFO_vue_parameters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sessionId` (`sessionId`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `INFO_CMTDTP`
--
ALTER TABLE `INFO_CMTDTP`
  MODIFY `id_CMTDTP` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_enseignant`
--
ALTER TABLE `INFO_enseignant`
  MODIFY `id_enseignant` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  MODIFY `id_module` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  MODIFY `id_promo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_seance`
--
ALTER TABLE `INFO_seance`
  MODIFY `id_seance` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_vue_parameters`
--
ALTER TABLE `INFO_vue_parameters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `INFO_CMTDTP`
--
ALTER TABLE `INFO_CMTDTP`
  ADD CONSTRAINT `FK_enseignant_CMTDTP` FOREIGN KEY (`id_enseignant`) REFERENCES `INFO_enseignant` (`id_enseignant`),
  ADD CONSTRAINT `FK_module_CMTDTP` FOREIGN KEY (`id_module`) REFERENCES `INFO_module` (`id_module`);

--
-- Contraintes pour la table `INFO_CMTDTP_as_promo`
--
ALTER TABLE `INFO_CMTDTP_as_promo`
  ADD CONSTRAINT `INFO_CMTDTP_as_promo_ibfk_1` FOREIGN KEY (`id_CMTDTP`) REFERENCES `INFO_CMTDTP` (`id_CMTDTP`),
  ADD CONSTRAINT `INFO_CMTDTP_as_promo_ibfk_2` FOREIGN KEY (`id_promo`) REFERENCES `INFO_promo` (`id_promo`);

--
-- Contraintes pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  ADD CONSTRAINT `FK_enseignant` FOREIGN KEY (`id_enseignant`) REFERENCES `INFO_enseignant` (`id_enseignant`);

--
-- Contraintes pour la table `INFO_module_as_promo`
--
ALTER TABLE `INFO_module_as_promo`
  ADD CONSTRAINT `FK_module` FOREIGN KEY (`id_module`) REFERENCES `INFO_module` (`id_module`),
  ADD CONSTRAINT `FK_promo` FOREIGN KEY (`id_promo`) REFERENCES `INFO_promo` (`id_promo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
