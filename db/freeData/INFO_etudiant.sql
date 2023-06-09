-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 26 mai 2023 à 16:46
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
-- Structure de la table `INFO_etudiant`
--

CREATE TABLE `INFO_etudiant` (
  `id_etudiant` int(11) NOT NULL,
  `nom` varchar(25) NOT NULL,
  `prenom` varchar(25) NOT NULL,
  `numero_groupe_elementaire` int(11) NOT NULL,
  `id_promo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `INFO_etudiant`
--

INSERT INTO `INFO_etudiant` (`id_etudiant`, `nom`, `prenom`, `numero_groupe_elementaire`, `id_promo`) VALUES
(4, 'MARECHAL', 'ANTOINE', 1, 5),
(5, 'CEBALLERO', 'STEPHANIE', 1, 5),
(6, 'QUENTIN', 'CHRISTOPHE', 1, 5),
(7, 'BLANC', 'AUDE', 1, 5),
(8, 'VIGNE', 'FLORENCE', 1, 5),
(9, 'LE SAINT', 'FABRICE', 1, 5),
(10, 'LADEVIE', 'CHRISTELLE', 1, 5),
(11, 'IRAOLA', 'CLAIRE', 1, 5),
(12, 'PLAZONNET', 'PIERRE-ANTOINE', 1, 5),
(13, 'MORIAUX', 'QUENTIN', 1, 5),
(14, 'COUBLE', 'LAETICIA', 1, 5),
(15, 'DILHAC', 'BENOIT', 1, 5),
(19, 'PINCELOUP', 'STEPHANIE', 2, 5),
(20, 'CODRON', 'AMELIE', 2, 5),
(21, 'SERRE', 'FLORENCE', 2, 5),
(22, 'PY', 'FLORENCE', 2, 5),
(23, 'LE DREVO', 'MATHIEU', 2, 5),
(24, 'BOCHET', 'SEBASTIEN', 2, 5),
(25, 'CUCCO', 'NICOLAS', 2, 5),
(26, 'GUETTET', 'NICOLAS', 2, 5),
(27, 'VIVES', 'BENJAMIN', 2, 5),
(28, 'LIPPI', 'FRANCOISE', 2, 5),
(29, 'BEQUET', 'STEPHANE', 2, 5),
(30, 'BEURDELEY THOMAS', 'ARNAUD', 2, 5);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `INFO_etudiant`
--
ALTER TABLE `INFO_etudiant`
  ADD PRIMARY KEY (`id_etudiant`),
  ADD UNIQUE KEY `SECONDARY` (`nom`,`prenom`) USING BTREE,
  ADD KEY `FK_etudiant_id_promo` (`id_promo`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `INFO_etudiant`
--
ALTER TABLE `INFO_etudiant`
  MODIFY `id_etudiant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `INFO_etudiant`
--
ALTER TABLE `INFO_etudiant`
  ADD CONSTRAINT `FK_etudiant_id_promo` FOREIGN KEY (`id_promo`) REFERENCES `INFO_promo` (`id_promo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
