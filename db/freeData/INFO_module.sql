-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 05 juin 2023 à 10:53
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
-- Déchargement des données de la table `INFO_module`
--

INSERT INTO `INFO_module` (`id_module`, `code`, `nom`, `semestre`, `hCM`, `hTD`, `hTP`, `hTPTD`, `filiere`, `id_enseignant`, `commentaire`) VALUES
(1, 'INFO101', 'Introduction à l\'algorithmique', 1, 6, 9, 12, NULL, 'PEIP_A', 14, NULL),
(2, 'INFO202', 'Programmation et algorithmique', 2, 6, 9, 12, NULL, 'PEIP_A', 19, NULL),
(3, 'INFO201', 'Système d\'exploitation', 2, 6, 6, 15, NULL, 'PEIP_A', 15, NULL),
(12, 'INFO501', 'Numération et Algorithmique', 5, 10.5, 10.5, NULL, 16, 'INGE', 14, '- Est-il envisageable de programmer des séances de td (au moins 2) sur machine ?\r\n(ces séances se passeraient en salle de TP, avec 2 étudiants par machine)\r\n\r\n- Est-il possible de grouper les séances de TP n°2, 3 et 4 soit toutes les 3 avant Noël, soit toutes les 3 après Noël.\r\nEn effet, ces séances correspondent à un seul sujet de tp, et quand il y a la coupure de Noël, cela ne facilite pas les choses.\r\n\r\n* Enchainement C/TD/TP :\r\n\r\nC1\r\nC2\r\nC3\r\n    TD1\r\nC4\r\n    TD2\r\nC5\r\n    TD3\r\nC6\r\n    TD4\r\nC7\r\n    TD5, TD6\r\n        TP1\r\n    TD7\r\n        TP2, TP3, TP4\r\n\r\nLe CC est à placer après la fin complète du module.'),
(13, 'INFO502', 'Initiation aux BD', 5, 6, 4.5, 12, NULL, 'INGE', 18, 'CM en amphi\r\nTD en salles de TD\r\nTP en salles machines \r\nExam pas forcément en parallèle sur les 2 sites\r\n\r\nSi possible placer tous les CM, TD et TP entre la rentrée et Toussaint et placer l\'exam après la Toussaint\r\n\r\nRegrouper, si possible, la même 1/2 journée les TD des enseignants qui ont 2 groupes.\r\n\r\nOrdre des cours :\r\nCM1 -> CM2 -> TD1 -> CM3 -> TD2 -> TD3 -> TP1 -> TP2 -> TP3 -> Exam'),
(14, 'INFO641', 'Conception et Programmation Orienté Objet', 6, 9, 9, 8, 12, 'SNI', 8, NULL),
(15, 'INFO642', 'Base de Données et Technologies Web', 6, 8.5, 7.5, 20, NULL, 'SNI', 17, NULL),
(16, 'INFO743', 'Réseaux et Systèmes répartis', 7, 18, 16, 4, NULL, 'SNI', 16, NULL),
(17, 'INFO741', 'Systèmes embarqués et systèmes d\'exploitation', 7, 9, 3, 24, NULL, 'SNI', 12, NULL),
(18, 'INFO742', 'Méthodes de développement logiciel et qualité', 7, 12.5, 7.5, NULL, 16, 'SNI', 6, NULL),
(19, 'INFO790', 'Informatique', 7, NULL, NULL, NULL, NULL, 'ITII', 10, NULL),
(20, 'INFO851', 'Système embarqué 1', 8, 7.5, 9, 20, NULL, 'MM', 19, NULL),
(21, 'INFO890', 'Algorithmique et Base de Données', 8, NULL, NULL, NULL, NULL, 'ITII', 10, NULL),
(22, 'EASI890', 'Système embarqué', 8, NULL, NULL, NULL, NULL, 'ITII MC', 9, NULL),
(23, 'INFO951', 'Système embarqué 2', 9, 9, 3, 24, NULL, 'MM-MT', 12, 'Les CM est l\'exam sont communs avec INFO941'),
(24, 'INFO941', 'Système embarqué 2', 9, 9, 3, NULL, 24, 'SNI', 12, NULL),
(25, 'INFO942', 'Apprentissage automatique et fouille de données', 9, 12, NULL, 24, NULL, 'SNI', 24, NULL),
(26, 'INFO943', 'Internet des objets', 9, 3, 9, 24, NULL, 'SNI', 16, '1 seul groupe de TP dans 2 salles TP : Projet'),
(27, 'PROJ942', 'Reconnaissance de visages', 9, NULL, NULL, 36, NULL, 'SNI', 19, NULL),
(32, 'PROJ641', 'APP', 6, NULL, NULL, 24, NULL, 'SNI', 9, NULL),
(33, 'PROJ741', 'APP', 7, NULL, NULL, 24, NULL, 'SNI', 9, NULL),
(34, 'PROJ841', 'APP', 8, NULL, NULL, 40, NULL, 'SNI', 9, NULL),
(35, 'PROJ943', 'APP', 9, NULL, NULL, 24, NULL, 'SNI', 9, NULL),
(36, 'INFO305', 'Programmation objet I', 3, 6, 9, 12, NULL, 'PEIP_A', 17, NULL),
(39, 'INFO402', 'Programmation orientée objet II', 4, 6, 9, 12, NULL, 'PEIP_A', 17, NULL),
(41, 'INFO404', 'Bases de données', 4, 6, 9, 12, NULL, 'PEIP_A', 10, NULL),
(42, 'ISOC531', 'Sociétés numériques', 5, 13.5, NULL, 4, 22.5, 'IDU', 16, NULL),
(43, 'PROJ531', 'Gestion de projets', 5, 6, 6, 28, NULL, 'IDU', 6, NULL),
(44, 'INFO631', 'Logique et Programmation', 6, 10.5, 10.5, 20, NULL, 'IDU', 18, NULL),
(45, 'MATH531', 'Graphes et Langages', 5, 12, 12, 16, NULL, 'IDU', 18, NULL),
(46, 'INFO632', 'Systèmes d’exploitation et Virtualisation', 6, 10.5, 13.5, 16, NULL, 'IDU', 15, NULL),
(47, 'ISOC631', 'Plateformes collaboratives', 6, 13.5, 14.5, 12, NULL, 'IDU', 16, NULL),
(48, 'PROJ632', 'Projet Data Science', 6, NULL, NULL, NULL, 30, 'IDU', 13, NULL),
(49, 'PROJ631', 'Projet Algorithmique', 6, NULL, NULL, NULL, 42, 'IDU', 11, NULL),
(50, 'DATA731', 'Modélisation Stochastique', 7, 12, NULL, 24, NULL, 'IDU', 24, NULL),
(51, 'INFO731', 'Sécurité et Cryptographie', 7, 13.5, 22.5, 4, NULL, 'IDU', 16, NULL),
(52, 'INFO732', 'Comportement et Modélisation Dynamique', 7, 7.5, 6, 24, NULL, 'IDU', 8, NULL),
(53, 'PROJ731', 'Flux de Données et Accès Concurrents', 7, 4, NULL, NULL, 16, 'IDU', 15, NULL),
(54, 'DATA732', 'Analyse et visualisation de données', 7, 12, 23.5, NULL, NULL, 'IDU', 8, NULL),
(55, 'INFO734', 'Développement Full Stack', 7, 12, 24, NULL, NULL, 'IDU', 13, NULL),
(56, 'ISOC731', 'Économie et gouvernance de la donnée', 7, 15, 21, 4, NULL, 'IDU', 16, NULL),
(57, 'DATA831', 'Big Data', 8, 7.5, NULL, 12, NULL, 'IDU', 13, NULL),
(58, 'DATA832', 'Machine Learning 1', 8, 9, 9, 12, NULL, 'IDU', 11, NULL),
(59, 'INFO831', 'Informatique décisionnelle', 8, 9, 9, 12, NULL, 'IDU', 11, NULL),
(60, 'ISOC831', 'Dimension métiers', 8, 30, NULL, NULL, NULL, 'IDU', 18, NULL),
(61, 'INFO832', 'Qualité et tests logiciel', 8, 12, 12, 16, NULL, 'IDU', 18, NULL),
(62, 'INFO833', 'Systèmes distribués à large échelle', 8, 12, 13.5, 15, NULL, 'IDU', 15, NULL),
(63, 'INFO834', 'Bases de données distribuées', 8, 7.5, 7.5, 24, NULL, 'IDU', 6, NULL),
(64, 'PROJ831', 'Projet Informatique Données et Usages', 8, 4.5, NULL, NULL, 36, 'IDU', 13, NULL),
(65, 'INFO931', 'Optimisation et aide à la décision multicritère', 9, 12, 12, 16, NULL, 'IDU', 11, NULL),
(66, 'INFO932', 'Calcul haute performance et Cloud Computing', 9, 7.5, 7.5, 24, NULL, 'IDU', 15, NULL),
(67, 'PROJ931', 'Projet Usages', 9, NULL, NULL, 40, NULL, 'IDU', 15, NULL),
(68, 'DATA931', 'Machine Learning', 9, 12, 12, 16, NULL, 'IDU', 10, NULL),
(69, 'ISOC931', 'Innovation et Recherche', 9, 6, 12, 20, NULL, 'IDU', 10, NULL),
(70, 'PROJ932', 'Projet Data Science', 9, NULL, NULL, 40, NULL, 'IDU', 13, NULL),
(72, 'INFO850', 'Informatique - Computer science', 8, NULL, NULL, NULL, NULL, 'BAT-ALT', 29, NULL),
(73, 'INFO841', 'Sécurité des systèmes cyber-physiques', 8, 7.5, 4.5, 12, NULL, 'SNI', 16, NULL),
(74, 'INFO633', 'APP - Bases de données et technologies web', 6, 8.5, 7.5, 20, NULL, 'IDU', 17, NULL),
(75, 'INFO405', 'Projet de programmation', 4, NULL, 6, 15, NULL, '', 17, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
