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
  `username` varchar(25) NOT NULL,
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
-- Doublure de structure pour la vue `INFO_vue_Check_MCCC_prev`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_Check_MCCC_prev` (
`code` varchar(10)
,`site` varchar(25)
,`hCMmccc` float
,`hTDmccc` double
,`hTPmccc` double
,`hTPTDmccc` double
,`hCMprev` double
,`hTDprev` double
,`hTPprev` double
,`hTPTDprev` double
,`hCM non Plan` double
,`hTD non Plan` double
,`hTP non Plan` double
,`hTPTD non Plan` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_Check_MCC_prev_ADE`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_Check_MCC_prev_ADE` (
`code` varchar(10)
,`hCM MCCC` double
,`hTD MCCC` double
,`hTP MCCC` double
,`Heure CM` double
,`Heure TD` double
,`Heure TP` double
,`Heure Exam` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_enseignant_previsionel`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_enseignant_previsionel` (
`code` varchar(10)
,`module` varchar(50)
,`lieu` varchar(25)
,`type` varchar(10)
,`heure` float
,`enseignant` varchar(25)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_module`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_module` (
`code` varchar(10)
,`module` varchar(50)
,`semestre` int(11)
,`filiere` varchar(20)
,`lieu` varchar(25)
,`type` varchar(10)
,`heure` float
,`nom` varchar(25)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_module2`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_module2` (
`site` varchar(25)
,`code` varchar(10)
,`type` varchar(10)
,`Filière` mediumtext
,`prenom` varchar(25)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_modules`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_modules` (
`code` varchar(10)
,`nom` varchar(50)
,`semestre` int(11)
,`hCM` float
,`hTD` float
,`hTP` float
,`hTPTD` float
,`filières` mediumtext
,`parcours` mediumtext
,`sites` mediumtext
,`responsables` mediumtext
);

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
-- Doublure de structure pour la vue `INFO_vue_resume_heures`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_resume_heures` (
`nom` varchar(25)
,`Heure CM` double
,`Heure TD` double
,`Heure TP` double
,`Heure Exam` double
,`Heures effectives` double
,`Heure eTD` double
,`service` bigint(12)
,`Difference` double
,`commentaire` varchar(150)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_resume_responsabilite`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_resume_responsabilite` (
`nom` varchar(25)
,`responsabilite` bigint(21)
,`modules` mediumtext
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_semestre_previsionel`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_semestre_previsionel` (
`id` int(11)
,`code` varchar(10)
,`module` varchar(50)
,`lieu` varchar(25)
,`type` varchar(10)
,`heure` float
,`enseignant` varchar(25)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `INFO_vue_semestre_reel`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `INFO_vue_semestre_reel` (
`code` varchar(10)
,`module` varchar(50)
,`type` varchar(10)
,`heure` decimal(39,1)
,`enseignant` varchar(25)
);

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_check_module_as_not_promo`
--
DROP TABLE IF EXISTS `INFO_check_module_as_not_promo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `INFO_check_module_as_not_promo`  AS SELECT `INFO_module`.`id_module` AS `id_module` FROM (`INFO_module` left join `INFO_module_as_promo` on(`INFO_module`.`id_module` = `INFO_module_as_promo`.`id_module`)) WHERE `INFO_module_as_promo`.`id_module` is null ORDER BY `INFO_module`.`id_module` ASC  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_intervenants`
--
DROP TABLE IF EXISTS `INFO_intervenants`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_intervenants`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_module`.`nom` AS `module`, `INFO_CMTDTP`.`lieu` AS `lieu`, `INFO_CMTDTP`.`type` AS `type`, `INFO_CMTDTP`.`heure` AS `heure`, `INFO_enseignant`.`nom` AS `enseignant` FROM ((`INFO_CMTDTP` join `INFO_enseignant`) join `INFO_module`) WHERE `INFO_CMTDTP`.`id_enseignant` = `INFO_enseignant`.`id_enseignant` AND `INFO_CMTDTP`.`id_module` = `INFO_module`.`id_module``id_module`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_interventions`
--
DROP TABLE IF EXISTS `INFO_interventions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_interventions`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_module`.`nom` AS `module`, `INFO_CMTDTP`.`lieu` AS `lieu`, `INFO_CMTDTP`.`type` AS `type`, `INFO_CMTDTP`.`heure` AS `heure`, `INFO_enseignant`.`nom` AS `enseignant`, group_concat(`INFO_promo`.`nom_filiere` separator ',') AS `filières` FROM ((((`INFO_CMTDTP` join `INFO_enseignant`) join `INFO_module`) join `INFO_CMTDTP_as_promo`) join `INFO_promo`) WHERE `INFO_CMTDTP`.`id_enseignant` = `INFO_enseignant`.`id_enseignant` AND `INFO_CMTDTP`.`id_module` = `INFO_module`.`id_module` AND `INFO_CMTDTP`.`id_CMTDTP` = `INFO_CMTDTP_as_promo`.`id_CMTDTP` AND `INFO_CMTDTP_as_promo`.`id_promo` = `INFO_promo`.`id_promo` GROUP BY `INFO_module`.`code`, `INFO_module`.`nom`, `INFO_CMTDTP`.`lieu`, `INFO_CMTDTP`.`type`, `INFO_CMTDTP`.`heure`, `INFO_enseignant`.`nom``nom`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_module_2_promo_mccc`
--
DROP TABLE IF EXISTS `INFO_module_2_promo_mccc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_module_2_promo_mccc`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_promo`.`site` AS `site`, `INFO_module`.`hCM` AS `hCMmccc`, sum(`INFO_module`.`hTD` * `INFO_promo`.`nbGroupeTD`) AS `hTDmccc`, sum(`INFO_module`.`hTP` * `INFO_promo`.`nbGroupeTP`) AS `hTPmccc`, sum(`INFO_module`.`hTPTD` * `INFO_promo`.`nbGroupeTD`) AS `hTPTDmccc` FROM ((`INFO_module` join `INFO_module_as_promo` on(`INFO_module`.`id_module` = `INFO_module_as_promo`.`id_module`)) join `INFO_promo` on(`INFO_module_as_promo`.`id_promo` = `INFO_promo`.`id_promo`)) WHERE 1 GROUP BY `INFO_module`.`code`, `INFO_promo`.`site` ORDER BY `INFO_module`.`semestre` ASC, `INFO_module`.`code` ASC  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_module_2_promo_prev`
--
DROP TABLE IF EXISTS `INFO_module_2_promo_prev`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_module_2_promo_prev`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_CMTDTP`.`lieu` AS `site`, sum(case when `INFO_CMTDTP`.`type` = 'CM' then `INFO_CMTDTP`.`heure` end) AS `hCMprev`, sum(case when `INFO_CMTDTP`.`type` = 'TD' then `INFO_CMTDTP`.`heure` end) AS `hTDprev`, sum(case when `INFO_CMTDTP`.`type` = 'TP' then `INFO_CMTDTP`.`heure` end) AS `hTPprev`, sum(case when `INFO_CMTDTP`.`type` = 'TPTD' then `INFO_CMTDTP`.`heure` end) AS `hTPTDprev` FROM (`INFO_CMTDTP` join `INFO_module` on(`INFO_CMTDTP`.`id_module` = `INFO_module`.`id_module`)) WHERE 1 GROUP BY `INFO_module`.`code`, `INFO_CMTDTP`.`lieu` ORDER BY `INFO_module`.`semestre` ASC, `INFO_module`.`code` ASC  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_Check_MCCC_prev`
--
DROP TABLE IF EXISTS `INFO_vue_Check_MCCC_prev`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_Check_MCCC_prev`  AS SELECT `INFO_module_2_promo_mccc`.`code` AS `code`, `INFO_module_2_promo_mccc`.`site` AS `site`, `INFO_module_2_promo_mccc`.`hCMmccc` AS `hCMmccc`, `INFO_module_2_promo_mccc`.`hTDmccc` AS `hTDmccc`, `INFO_module_2_promo_mccc`.`hTPmccc` AS `hTPmccc`, `INFO_module_2_promo_mccc`.`hTPTDmccc` AS `hTPTDmccc`, `INFO_module_2_promo_prev`.`hCMprev` AS `hCMprev`, `INFO_module_2_promo_prev`.`hTDprev` AS `hTDprev`, `INFO_module_2_promo_prev`.`hTPprev` AS `hTPprev`, `INFO_module_2_promo_prev`.`hTPTDprev` AS `hTPTDprev`, ifnull(`INFO_module_2_promo_mccc`.`hCMmccc`,0) - ifnull(`INFO_module_2_promo_prev`.`hCMprev`,0) AS `hCM non Plan`, ifnull(`INFO_module_2_promo_mccc`.`hTDmccc`,0) - ifnull(`INFO_module_2_promo_prev`.`hTDprev`,0) AS `hTD non Plan`, ifnull(`INFO_module_2_promo_mccc`.`hTPmccc`,0) - ifnull(`INFO_module_2_promo_prev`.`hTPprev`,0) AS `hTP non Plan`, ifnull(`INFO_module_2_promo_mccc`.`hTPTDmccc`,0) - ifnull(`INFO_module_2_promo_prev`.`hTPTDprev`,0) AS `hTPTD non Plan` FROM (`INFO_module_2_promo_mccc` join `INFO_module_2_promo_prev` on(`INFO_module_2_promo_mccc`.`code` = `INFO_module_2_promo_prev`.`code` and `INFO_module_2_promo_mccc`.`site` = `INFO_module_2_promo_prev`.`site`)) WHERE 11  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_Check_MCC_prev_ADE`
--
DROP TABLE IF EXISTS `INFO_vue_Check_MCC_prev_ADE`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_Check_MCC_prev_ADE`  AS SELECT `INFO_module`.`code` AS `code`, ifnull(`INFO_module`.`hCM`,0) AS `hCM MCCC`, ifnull(`INFO_module`.`hTD`,0) + ifnull(`INFO_module`.`hTPTD`,0) AS `hTD MCCC`, ifnull(`INFO_module`.`hTP`,0) AS `hTP MCCC`, sum(case when `INFO_CMTDTP`.`type` = 'CM' then `INFO_CMTDTP`.`heure` end) AS `Heure CM`, sum(case when `INFO_CMTDTP`.`type` = 'TD' then `INFO_CMTDTP`.`heure` end) AS `Heure TD`, sum(case when `INFO_CMTDTP`.`type` = 'TP' then `INFO_CMTDTP`.`heure` end) AS `Heure TP`, sum(case when `INFO_CMTDTP`.`type` = 'Exam' then `INFO_CMTDTP`.`heure` end) AS `Heure Exam` FROM ((`INFO_module` join `INFO_vue_parameters`) join `INFO_CMTDTP`) WHERE `INFO_module`.`code` = convert(`INFO_vue_parameters`.`module` using utf8) AND `INFO_module`.`id_module` = `INFO_CMTDTP`.`id_module` GROUP BY `INFO_module`.`code`, `INFO_module`.`hCM`, `INFO_module`.`hTD`, `INFO_module`.`hTP`, `INFO_module`.`hTPTD``hTPTD`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_enseignant_previsionel`
--
DROP TABLE IF EXISTS `INFO_vue_enseignant_previsionel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_enseignant_previsionel`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_module`.`nom` AS `module`, `INFO_CMTDTP`.`lieu` AS `lieu`, `INFO_CMTDTP`.`type` AS `type`, `INFO_CMTDTP`.`heure` AS `heure`, `INFO_enseignant`.`nom` AS `enseignant` FROM (((`INFO_CMTDTP` join `INFO_module`) join `INFO_vue_parameters`) join `INFO_enseignant`) WHERE `INFO_module`.`id_module` = `INFO_CMTDTP`.`id_module` AND convert(`INFO_vue_parameters`.`enseignant` using utf8) = `INFO_enseignant`.`nom` AND `INFO_CMTDTP`.`id_enseignant` = `INFO_enseignant`.`id_enseignant``id_enseignant`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_module`
--
DROP TABLE IF EXISTS `INFO_vue_module`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_module`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_module`.`nom` AS `module`, `INFO_module`.`semestre` AS `semestre`, `INFO_module`.`filiere` AS `filiere`, `INFO_CMTDTP`.`lieu` AS `lieu`, `INFO_CMTDTP`.`type` AS `type`, `INFO_CMTDTP`.`heure` AS `heure`, `INFO_enseignant`.`nom` AS `nom` FROM (((`INFO_module` join `INFO_CMTDTP`) join `INFO_enseignant`) join `INFO_vue_parameters`) WHERE `INFO_module`.`id_module` = `INFO_CMTDTP`.`id_module` AND `INFO_CMTDTP`.`id_enseignant` = `INFO_enseignant`.`id_enseignant` AND `INFO_module`.`code` = convert(`INFO_vue_parameters`.`module` using utf8)  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_module2`
--
DROP TABLE IF EXISTS `INFO_vue_module2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_module2`  AS SELECT `INFO_promo`.`site` AS `site`, `INFO_module`.`code` AS `code`, `INFO_CMTDTP`.`type` AS `type`, group_concat(distinct `INFO_promo`.`nom_filiere` separator ', ') AS `Filière`, `INFO_enseignant`.`prenom` AS `prenom` FROM (((((`INFO_enseignant` join `INFO_CMTDTP`) join `INFO_CMTDTP_as_promo`) join `INFO_promo`) join `INFO_module`) join `INFO_vue_parameters`) WHERE `INFO_enseignant`.`id_enseignant` = `INFO_CMTDTP`.`id_enseignant` AND `INFO_CMTDTP`.`id_CMTDTP` = `INFO_CMTDTP_as_promo`.`id_CMTDTP` AND `INFO_CMTDTP_as_promo`.`id_promo` = `INFO_promo`.`id_promo` AND `INFO_module`.`id_module` = `INFO_CMTDTP`.`id_module` AND `INFO_module`.`code` = convert(`INFO_vue_parameters`.`module` using utf8) GROUP BY `INFO_promo`.`site`, `INFO_enseignant`.`prenom`, `INFO_module`.`code`, `INFO_CMTDTP`.`type`, `INFO_CMTDTP`.`lieu``lieu`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_modules`
--
DROP TABLE IF EXISTS `INFO_vue_modules`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_modules`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_module`.`nom` AS `nom`, `INFO_module`.`semestre` AS `semestre`, `INFO_module`.`hCM` AS `hCM`, `INFO_module`.`hTD` AS `hTD`, `INFO_module`.`hTP` AS `hTP`, `INFO_module`.`hTPTD` AS `hTPTD`, group_concat(distinct `INFO_promo`.`nom_filiere` separator ', ') AS `filières`, group_concat(distinct `INFO_promo`.`parcour` separator ', ') AS `parcours`, group_concat(distinct `INFO_promo`.`site` separator ', ') AS `sites`, group_concat(distinct `INFO_enseignant`.`prenom` separator ', ') AS `responsables` FROM (((`INFO_module` join `INFO_module_as_promo`) join `INFO_promo`) left join `INFO_enseignant` on(`INFO_module`.`id_enseignant` = `INFO_enseignant`.`id_enseignant`)) WHERE `INFO_module`.`id_module` = `INFO_module_as_promo`.`id_module` AND `INFO_module_as_promo`.`id_promo` = `INFO_promo`.`id_promo` GROUP BY `INFO_module`.`code`, `INFO_module`.`nom`, `INFO_module`.`semestre`, `INFO_module`.`hCM`, `INFO_module`.`hTD`, `INFO_module`.`hTP`, `INFO_module`.`hTPTD` ORDER BY `INFO_module`.`semestre` ASC, `INFO_module`.`code` ASC  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_resume_heures`
--
DROP TABLE IF EXISTS `INFO_vue_resume_heures`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_resume_heures`  AS SELECT `INFO_enseignant`.`nom` AS `nom`, sum(case when `INFO_CMTDTP`.`type` = 'CM' then `INFO_CMTDTP`.`heure` end) AS `Heure CM`, sum(case when `INFO_CMTDTP`.`type` = 'TD' then `INFO_CMTDTP`.`heure` end) AS `Heure TD`, sum(case when `INFO_CMTDTP`.`type` = 'TP' then `INFO_CMTDTP`.`heure` end) AS `Heure TP`, sum(case when `INFO_CMTDTP`.`type` = 'Exam' then `INFO_CMTDTP`.`heure` end) AS `Heure Exam`, sum(`INFO_CMTDTP`.`heure`) AS `Heures effectives`, sum(case `INFO_CMTDTP`.`type` when 'CM' then 1.5 * `INFO_CMTDTP`.`heure` when 'TD' then `INFO_CMTDTP`.`heure` when 'TP' then `INFO_CMTDTP`.`heure` when 'Exam' then 1.5 * `INFO_CMTDTP`.`heure` end) AS `Heure eTD`, `INFO_enseignant`.`service statutaire`- `INFO_enseignant`.`décharge` AS `service`, `INFO_enseignant`.`service statutaire`- `INFO_enseignant`.`décharge` - sum(case `INFO_CMTDTP`.`type` when 'CM' then 1.5 * `INFO_CMTDTP`.`heure` when 'TD' then `INFO_CMTDTP`.`heure` when 'TP' then `INFO_CMTDTP`.`heure` when 'Exam' then 1.5 * `INFO_CMTDTP`.`heure` end) AS `Difference`, `INFO_enseignant`.`commentaire` AS `commentaire` FROM (`INFO_CMTDTP` join `INFO_enseignant`) WHERE `INFO_CMTDTP`.`id_enseignant` = `INFO_enseignant`.`id_enseignant` GROUP BY `INFO_enseignant`.`nom`, `INFO_enseignant`.`service statutaire`, `INFO_enseignant`.`décharge`, `INFO_enseignant`.`commentaire``commentaire`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_resume_responsabilite`
--
DROP TABLE IF EXISTS `INFO_vue_resume_responsabilite`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_resume_responsabilite`  AS SELECT `INFO_enseignant`.`nom` AS `nom`, count(`INFO_module`.`id_module`) AS `responsabilite`, group_concat(distinct `INFO_module`.`code` separator ', ') AS `modules` FROM (`INFO_enseignant` join `INFO_module`) WHERE `INFO_module`.`id_enseignant` = `INFO_enseignant`.`id_enseignant` GROUP BY `INFO_enseignant`.`nom``nom`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_semestre_previsionel`
--
DROP TABLE IF EXISTS `INFO_vue_semestre_previsionel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`learnagement`@`%` SQL SECURITY DEFINER VIEW `INFO_vue_semestre_previsionel`  AS SELECT `INFO_CMTDTP`.`id_CMTDTP` AS `id`, `INFO_module`.`code` AS `code`, `INFO_module`.`nom` AS `module`, `INFO_CMTDTP`.`lieu` AS `lieu`, `INFO_CMTDTP`.`type` AS `type`, `INFO_CMTDTP`.`heure` AS `heure`, `INFO_enseignant`.`nom` AS `enseignant` FROM (((`INFO_CMTDTP` join `INFO_module`) join `INFO_vue_parameters`) join `INFO_enseignant`) WHERE `INFO_module`.`id_module` = `INFO_CMTDTP`.`id_module` AND `INFO_vue_parameters`.`semestre` = `INFO_module`.`semestre` AND `INFO_CMTDTP`.`id_enseignant` = `INFO_enseignant`.`id_enseignant``id_enseignant`  ;

-- --------------------------------------------------------

--
-- Structure de la vue `INFO_vue_semestre_reel`
--
DROP TABLE IF EXISTS `INFO_vue_semestre_reel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `INFO_vue_semestre_reel`  AS SELECT `INFO_module`.`code` AS `code`, `INFO_module`.`nom` AS `module`, `INFO_seance`.`type` AS `type`, truncate(sum(time_to_sec(`INFO_seance`.`duree`)) / 3600,1) AS `heure`, `INFO_enseignant`.`nom` AS `enseignant` FROM ((`INFO_seance` join `INFO_module` on(`INFO_seance`.`id_module` = `INFO_module`.`id_module`)) join `INFO_enseignant` on(`INFO_seance`.`id_enseignant` = `INFO_enseignant`.`id_enseignant`)) WHERE 1 GROUP BY `INFO_module`.`code`, `INFO_seance`.`type`, `INFO_enseignant`.`nom`, `INFO_module`.`nom` ORDER BY `INFO_enseignant`.`nom` ASC, `INFO_module`.`nom` ASC  ;

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
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `nom` (`nom`,`prenom`) USING BTREE;

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
