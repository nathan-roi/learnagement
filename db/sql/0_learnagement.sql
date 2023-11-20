-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql
-- Généré le : lun. 20 nov. 2023 à 21:19
-- Version du serveur : 8.0.33
-- Version de PHP : 8.2.8

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
-- Structure de la table `INFO_dependances`
--

CREATE TABLE `INFO_dependances` (
  `id_dependances` int NOT NULL,
  `id_module precedant` int NOT NULL,
  `type precedant` varchar(10) NOT NULL,
  `numero seance precedant` int NOT NULL,
  `id_module suivant` int NOT NULL,
  `type suivant` varchar(10) NOT NULL,
  `numero seance suivant` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_dependances_seance_to_be_planned`
--

CREATE TABLE `INFO_dependances_seance_to_be_planned` (
  `precedent` int NOT NULL,
  `successeur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_dependance_sequence`
--

CREATE TABLE `INFO_dependance_sequence` (
  `id_squence_prev` int NOT NULL,
  `id_squence_next` int NOT NULL,
  `id_responsable` int NOT NULL,
  `modifiable` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_enseignant`
--

CREATE TABLE `INFO_enseignant` (
  `id_enseignant` int NOT NULL,
  `prenom` varchar(25) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `fullName` varchar(50) DEFAULT NULL,
  `mail` varchar(25) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `statut` enum('permanent','vacataire') NOT NULL DEFAULT 'permanent',
  `composante` varchar(25) DEFAULT NULL,
  `service statutaire` int NOT NULL,
  `décharge` int NOT NULL,
  `service effectif` float NOT NULL DEFAULT '192',
  `HCAutorisees` tinyint(1) NOT NULL DEFAULT '1',
  `commentaire` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_filiere`
--

CREATE TABLE `INFO_filiere` (
  `nom_filiere` varchar(11) NOT NULL,
  `nom_long` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_module`
--

CREATE TABLE `INFO_module` (
  `id_module` int NOT NULL,
  `code_module` varchar(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `id_semestre` tinyint NOT NULL,
  `hCM` float DEFAULT NULL,
  `hTD` float DEFAULT NULL,
  `hTP` float DEFAULT NULL,
  `hTPTD` float DEFAULT NULL,
  `hPROJ` float DEFAULT NULL,
  `type` enum('Specialite','Transverse') DEFAULT 'Specialite',
  `id_responsable` int DEFAULT NULL,
  `commentaire` text,
  `modifiable` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_module_as_promo`
--

CREATE TABLE `INFO_module_as_promo` (
  `id_module` int NOT NULL,
  `id_promo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_module_sequencage`
--

CREATE TABLE `INFO_module_sequencage` (
  `id_module_sequencage` int NOT NULL,
  `id_module` int NOT NULL,
  `type` varchar(10) NOT NULL,
  `numero_ordre` int DEFAULT NULL,
  `duree_h` decimal(10,1) NOT NULL,
  `id_responsable` int DEFAULT NULL,
  `commentaire` text,
  `modifiable` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_parameters_of_views`
--

CREATE TABLE `INFO_parameters_of_views` (
  `id_parameters_of_views` int NOT NULL,
  `sessionId` int NOT NULL,
  `id_semestre` tinyint DEFAULT NULL,
  `code_module` int DEFAULT NULL,
  `fullname` int DEFAULT NULL,
  `nom_filiere` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_promo`
--

CREATE TABLE `INFO_promo` (
  `id_promo` int NOT NULL,
  `nom_filiere` varchar(11) NOT NULL,
  `statut` enum('FISE','FISA','FISEA','FISECP') DEFAULT 'FISE',
  `annee` int NOT NULL,
  `parcour` varchar(25) DEFAULT NULL,
  `site` varchar(25) NOT NULL,
  `nbGroupeCM` int NOT NULL DEFAULT '1',
  `nbGroupeTD` int NOT NULL,
  `nbGroupeTP` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_seanceType`
--

CREATE TABLE `INFO_seanceType` (
  `type` varchar(10) NOT NULL,
  `commentaire` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_seance_planned`
--

CREATE TABLE `INFO_seance_planned` (
  `id_seance_planned` int NOT NULL,
  `type` varchar(10) NOT NULL,
  `date` datetime NOT NULL,
  `duree_h` time NOT NULL,
  `id_module` int NOT NULL,
  `id_enseignant` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_seance_to_be_planned`
--

CREATE TABLE `INFO_seance_to_be_planned` (
  `id_seance_to_be_planned` int NOT NULL,
  `lieu` varchar(25) NOT NULL,
  `type` varchar(10) NOT NULL,
  `heure` float NOT NULL,
  `id_enseignant` int DEFAULT NULL,
  `id_module` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_seance_to_be_planned_as_promo`
--

CREATE TABLE `INFO_seance_to_be_planned_as_promo` (
  `id_seance_to_be_planned` int NOT NULL,
  `id_promo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INFO_semestre`
--

CREATE TABLE `INFO_semestre` (
  `id_semestre` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `VUE_MCCC`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `VUE_MCCC` (
`code_module` varchar(10)
,`commentaire` text
,`filieres` text
,`hCM` float
,`hTD` float
,`hTP` float
,`hTPTD` float
,`id_module` int
,`nom` varchar(50)
,`responsable` varchar(51)
,`semestre` tinyint
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `VUE_module`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `VUE_module` (
`code_module` varchar(10)
,`filiere` varchar(11)
,`Filière` text
,`heure` float
,`lieu` varchar(25)
,`module` varchar(50)
,`nom` varchar(25)
,`prenom` varchar(25)
,`semestre` tinyint
,`type` varchar(10)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `VUE_responsable`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `VUE_responsable` (
`modules` text
,`responsabilite` bigint
,`responsable` varchar(51)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `VUE_resume_charge`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `VUE_resume_charge` (
`charge à couvrir` double
,`service avec décharge` double
,`service statutaire` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Structure de la vue `VUE_MCCC`
--
DROP TABLE IF EXISTS `VUE_MCCC`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `VUE_MCCC`  AS SELECT `INFO_module`.`id_module` AS `id_module`, `INFO_module`.`code_module` AS `code_module`, `INFO_module`.`nom` AS `nom`, `INFO_module`.`id_semestre` AS `semestre`, `INFO_module`.`hCM` AS `hCM`, `INFO_module`.`hTD` AS `hTD`, `INFO_module`.`hTP` AS `hTP`, `INFO_module`.`hTPTD` AS `hTPTD`, group_concat(`INFO_promo`.`nom_filiere` separator ', ') AS `filieres`, concat(`INFO_enseignant`.`prenom`,' ',`INFO_enseignant`.`nom`) AS `responsable`, `INFO_module`.`commentaire` AS `commentaire` FROM (((`INFO_module` join `INFO_module_as_promo` on((`INFO_module`.`id_module` = `INFO_module_as_promo`.`id_module`))) join `INFO_promo` on((`INFO_module_as_promo`.`id_promo` = `INFO_promo`.`id_promo`))) join `INFO_enseignant` on((`INFO_module`.`id_responsable` = `INFO_enseignant`.`id_enseignant`))) WHERE (0 <> 1) GROUP BY `INFO_module`.`id_module` ;

-- --------------------------------------------------------

--
-- Structure de la vue `VUE_module`
--
DROP TABLE IF EXISTS `VUE_module`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `VUE_module`  AS SELECT `INFO_module`.`code_module` AS `code_module`, `INFO_module`.`nom` AS `module`, `INFO_module`.`id_semestre` AS `semestre`, `INFO_promo`.`nom_filiere` AS `filiere`, `INFO_seance_to_be_planned`.`lieu` AS `lieu`, `INFO_seance_to_be_planned`.`type` AS `type`, `INFO_seance_to_be_planned`.`heure` AS `heure`, `INFO_enseignant`.`nom` AS `nom`, `INFO_enseignant`.`prenom` AS `prenom`, group_concat(`INFO_promo`.`nom_filiere` separator ', ') AS `Filière` FROM ((((((`INFO_module` join `INFO_module_as_promo` on((`INFO_module`.`id_module` = `INFO_module_as_promo`.`id_module`))) join `INFO_promo` on((`INFO_module_as_promo`.`id_promo` = `INFO_promo`.`id_promo`))) join `INFO_seance_to_be_planned` on((`INFO_module`.`id_module` = `INFO_seance_to_be_planned`.`id_module`))) join `INFO_parameters_of_views` on((`INFO_module`.`code_module` = convert(`INFO_parameters_of_views`.`code_module` using utf8mb3)))) join `INFO_seance_to_be_planned_as_promo` on((`INFO_seance_to_be_planned`.`id_seance_to_be_planned` = `INFO_seance_to_be_planned_as_promo`.`id_seance_to_be_planned`))) left join `INFO_enseignant` on((`INFO_seance_to_be_planned`.`id_enseignant` = `INFO_enseignant`.`id_enseignant`))) GROUP BY `INFO_module`.`code_module`, `INFO_module`.`nom`, `INFO_module`.`id_semestre`, `INFO_promo`.`nom_filiere`, `INFO_seance_to_be_planned`.`lieu`, `INFO_seance_to_be_planned`.`lieu`, `INFO_seance_to_be_planned`.`type`, `INFO_seance_to_be_planned`.`heure`, `INFO_enseignant`.`nom`, `INFO_enseignant`.`prenom` ;

-- --------------------------------------------------------

--
-- Structure de la vue `VUE_responsable`
--
DROP TABLE IF EXISTS `VUE_responsable`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `VUE_responsable`  AS SELECT concat(`INFO_enseignant`.`prenom`,' ',`INFO_enseignant`.`nom`) AS `responsable`, count(`INFO_module`.`id_module`) AS `responsabilite`, group_concat(distinct `INFO_module`.`code_module` separator ', ') AS `modules` FROM (`INFO_enseignant` join `INFO_module`) WHERE (`INFO_module`.`id_responsable` = `INFO_enseignant`.`id_enseignant`) GROUP BY `INFO_enseignant`.`nom`, `INFO_enseignant`.`prenom` ;

-- --------------------------------------------------------

--
-- Structure de la vue `VUE_resume_charge`
--
DROP TABLE IF EXISTS `VUE_resume_charge`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `VUE_resume_charge`  AS SELECT `service`.`service statutaire` AS `service statutaire`, `service`.`service avec décharge` AS `service avec décharge`, `charge`.`charge à couvrir` AS `charge à couvrir` FROM ((select sum(`INFO_enseignant`.`service statutaire`) AS `service statutaire`,sum(`INFO_enseignant`.`service effectif`) AS `service avec décharge` from `INFO_enseignant` where ((`INFO_enseignant`.`statut` = 'permanent') and (`INFO_enseignant`.`composante` = 'polytech'))) `service` join (select (((sum(((`INFO_module`.`hCM` * 1.5) * `INFO_promo`.`nbGroupeCM`)) + sum((`INFO_module`.`hTD` * `INFO_promo`.`nbGroupeTD`))) + sum((`INFO_module`.`hTP` * `INFO_promo`.`nbGroupeTP`))) + sum((`INFO_module`.`hTPTD` * `INFO_promo`.`nbGroupeTD`))) AS `charge à couvrir` from ((`INFO_module` join `INFO_module_as_promo` on((`INFO_module`.`id_module` = `INFO_module_as_promo`.`id_module`))) join `INFO_promo` on((`INFO_module_as_promo`.`id_promo` = `INFO_promo`.`id_promo`)))) `charge`) ;

--
-- Index pour les tables déchargées
--

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
-- Index pour la table `INFO_dependances_seance_to_be_planned`
--
ALTER TABLE `INFO_dependances_seance_to_be_planned`
  ADD PRIMARY KEY (`precedent`,`successeur`);

--
-- Index pour la table `INFO_dependance_sequence`
--
ALTER TABLE `INFO_dependance_sequence`
  ADD PRIMARY KEY (`id_squence_prev`,`id_squence_next`),
  ADD KEY `FK_dependance_sequence_as_module_sequencage_next` (`id_squence_next`),
  ADD KEY `FK_dependance_sequence_as_enseignant` (`id_responsable`);

--
-- Index pour la table `INFO_enseignant`
--
ALTER TABLE `INFO_enseignant`
  ADD PRIMARY KEY (`id_enseignant`),
  ADD UNIQUE KEY `mail` (`mail`),
  ADD UNIQUE KEY `SECONDARY` (`fullName`) USING BTREE;

--
-- Index pour la table `INFO_filiere`
--
ALTER TABLE `INFO_filiere`
  ADD PRIMARY KEY (`nom_filiere`),
  ADD UNIQUE KEY `SECONDARY` (`nom_filiere`) USING BTREE;

--
-- Index pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  ADD PRIMARY KEY (`id_module`),
  ADD UNIQUE KEY `SECONDARY` (`code_module`) USING BTREE,
  ADD KEY `FK_module_as_enseignant` (`id_responsable`),
  ADD KEY `FK_module_as_semestre` (`id_semestre`);

--
-- Index pour la table `INFO_module_as_promo`
--
ALTER TABLE `INFO_module_as_promo`
  ADD PRIMARY KEY (`id_module`,`id_promo`),
  ADD KEY `FK_promo` (`id_promo`);

--
-- Index pour la table `INFO_module_sequencage`
--
ALTER TABLE `INFO_module_sequencage`
  ADD PRIMARY KEY (`id_module_sequencage`),
  ADD UNIQUE KEY `SECONDARY` (`id_module`,`type`,`numero_ordre`) USING BTREE,
  ADD KEY `FK_module_sequencage_as_seanceType` (`type`),
  ADD KEY `FK_module_sequencage_as_module` (`id_module`),
  ADD KEY `FK_module_sequencage_as_enseignant` (`id_responsable`);

--
-- Index pour la table `INFO_parameters_of_views`
--
ALTER TABLE `INFO_parameters_of_views`
  ADD PRIMARY KEY (`id_parameters_of_views`),
  ADD UNIQUE KEY `sessionId` (`sessionId`),
  ADD KEY `FK_parameters_of_views_as_semestre` (`id_semestre`),
  ADD KEY `FK_parameters_of_views_as_module` (`code_module`),
  ADD KEY `FK_parameters_of_views_as_enseignant` (`fullname`),
  ADD KEY `FK_parameters_of_views_as_filiere` (`nom_filiere`);

--
-- Index pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  ADD PRIMARY KEY (`id_promo`),
  ADD UNIQUE KEY `SECONDARY` (`nom_filiere`,`statut`,`annee`,`site`,`parcour`) USING BTREE;

--
-- Index pour la table `INFO_seanceType`
--
ALTER TABLE `INFO_seanceType`
  ADD PRIMARY KEY (`type`),
  ADD UNIQUE KEY `SECONDARY` (`type`);

--
-- Index pour la table `INFO_seance_planned`
--
ALTER TABLE `INFO_seance_planned`
  ADD PRIMARY KEY (`id_seance_planned`),
  ADD UNIQUE KEY `date` (`date`,`id_enseignant`),
  ADD KEY `FK_seance_seanceType` (`type`);

--
-- Index pour la table `INFO_seance_to_be_planned`
--
ALTER TABLE `INFO_seance_to_be_planned`
  ADD PRIMARY KEY (`id_seance_to_be_planned`),
  ADD KEY `FK_module_seance_to_be_planned` (`id_module`),
  ADD KEY `FK_enseignant_seance_to_be_planned` (`id_enseignant`),
  ADD KEY `FK_seance_to_be_planned_seanceType` (`type`);

--
-- Index pour la table `INFO_seance_to_be_planned_as_promo`
--
ALTER TABLE `INFO_seance_to_be_planned_as_promo`
  ADD PRIMARY KEY (`id_seance_to_be_planned`,`id_promo`),
  ADD KEY `INFO_seance_to_be_planned_as_promo_ibfk_2` (`id_promo`);

--
-- Index pour la table `INFO_semestre`
--
ALTER TABLE `INFO_semestre`
  ADD PRIMARY KEY (`id_semestre`),
  ADD UNIQUE KEY `SECONDARY` (`id_semestre`) USING BTREE;

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `INFO_enseignant`
--
ALTER TABLE `INFO_enseignant`
  MODIFY `id_enseignant` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  MODIFY `id_module` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_module_sequencage`
--
ALTER TABLE `INFO_module_sequencage`
  MODIFY `id_module_sequencage` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_parameters_of_views`
--
ALTER TABLE `INFO_parameters_of_views`
  MODIFY `id_parameters_of_views` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  MODIFY `id_promo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_seance_planned`
--
ALTER TABLE `INFO_seance_planned`
  MODIFY `id_seance_planned` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `INFO_seance_to_be_planned`
--
ALTER TABLE `INFO_seance_to_be_planned`
  MODIFY `id_seance_to_be_planned` int NOT NULL AUTO_INCREMENT;

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

--
-- Contraintes pour la table `INFO_dependance_sequence`
--
ALTER TABLE `INFO_dependance_sequence`
  ADD CONSTRAINT `FK_dependance_sequence_as_enseignant` FOREIGN KEY (`id_responsable`) REFERENCES `INFO_enseignant` (`id_enseignant`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_dependance_sequence_as_module_sequencage_next` FOREIGN KEY (`id_squence_next`) REFERENCES `INFO_module_sequencage` (`id_module_sequencage`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_dependance_sequence_as_module_sequencage_prev` FOREIGN KEY (`id_squence_prev`) REFERENCES `INFO_module_sequencage` (`id_module_sequencage`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `INFO_module`
--
ALTER TABLE `INFO_module`
  ADD CONSTRAINT `FK_module_as_enseignant` FOREIGN KEY (`id_responsable`) REFERENCES `INFO_enseignant` (`id_enseignant`),
  ADD CONSTRAINT `FK_module_as_semestre` FOREIGN KEY (`id_semestre`) REFERENCES `INFO_semestre` (`id_semestre`);

--
-- Contraintes pour la table `INFO_module_as_promo`
--
ALTER TABLE `INFO_module_as_promo`
  ADD CONSTRAINT `FK_module` FOREIGN KEY (`id_module`) REFERENCES `INFO_module` (`id_module`),
  ADD CONSTRAINT `FK_promo` FOREIGN KEY (`id_promo`) REFERENCES `INFO_promo` (`id_promo`);

--
-- Contraintes pour la table `INFO_module_sequencage`
--
ALTER TABLE `INFO_module_sequencage`
  ADD CONSTRAINT `FK_module_sequencage_as_enseignant` FOREIGN KEY (`id_responsable`) REFERENCES `INFO_enseignant` (`id_enseignant`),
  ADD CONSTRAINT `FK_module_sequencage_as_module` FOREIGN KEY (`id_module`) REFERENCES `INFO_module` (`id_module`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_module_sequencage_as_seanceType` FOREIGN KEY (`type`) REFERENCES `INFO_seanceType` (`type`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `INFO_parameters_of_views`
--
ALTER TABLE `INFO_parameters_of_views`
  ADD CONSTRAINT `FK_parameters_of_views_as_enseignant` FOREIGN KEY (`fullname`) REFERENCES `INFO_enseignant` (`id_enseignant`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_parameters_of_views_as_filiere` FOREIGN KEY (`nom_filiere`) REFERENCES `INFO_filiere` (`nom_filiere`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_parameters_of_views_as_module` FOREIGN KEY (`code_module`) REFERENCES `INFO_module` (`id_module`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_parameters_of_views_as_semestre` FOREIGN KEY (`id_semestre`) REFERENCES `INFO_semestre` (`id_semestre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `INFO_promo`
--
ALTER TABLE `INFO_promo`
  ADD CONSTRAINT `FK_filiere` FOREIGN KEY (`nom_filiere`) REFERENCES `INFO_filiere` (`nom_filiere`);

--
-- Contraintes pour la table `INFO_seance_planned`
--
ALTER TABLE `INFO_seance_planned`
  ADD CONSTRAINT `FK_seance_seanceType` FOREIGN KEY (`type`) REFERENCES `INFO_seanceType` (`type`);

--
-- Contraintes pour la table `INFO_seance_to_be_planned`
--
ALTER TABLE `INFO_seance_to_be_planned`
  ADD CONSTRAINT `FK_enseignant_seance_to_be_planned` FOREIGN KEY (`id_enseignant`) REFERENCES `INFO_enseignant` (`id_enseignant`),
  ADD CONSTRAINT `FK_module_seance_to_be_planned` FOREIGN KEY (`id_module`) REFERENCES `INFO_module` (`id_module`),
  ADD CONSTRAINT `FK_seance_to_be_planned_seanceType` FOREIGN KEY (`type`) REFERENCES `INFO_seanceType` (`type`);

--
-- Contraintes pour la table `INFO_seance_to_be_planned_as_promo`
--
ALTER TABLE `INFO_seance_to_be_planned_as_promo`
  ADD CONSTRAINT `INFO_seance_to_be_planned_as_promo_ibfk_1` FOREIGN KEY (`id_seance_to_be_planned`) REFERENCES `INFO_seance_to_be_planned` (`id_seance_to_be_planned`),
  ADD CONSTRAINT `INFO_seance_to_be_planned_as_promo_ibfk_2` FOREIGN KEY (`id_promo`) REFERENCES `INFO_promo` (`id_promo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
