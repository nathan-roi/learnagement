-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql
-- Généré le : lun. 06 nov. 2023 à 14:37
-- Version du serveur : 8.0.33
-- Version de PHP : 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
-- START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `learnagement`
--

DROP VIEW IF EXISTS VUE_module;
create view VUE_module as
select `learnagement`.`INFO_module`.`code_module` AS `code_module`,
       `learnagement`.`INFO_module`.`nom` AS `module`,
       `learnagement`.`INFO_module`.`id_semestre` AS `semestre`,
       `learnagement`.`INFO_promo`.`nom_filiere` AS `filiere`,
       `learnagement`.`INFO_seance_to_be_planned`.`lieu` AS `lieu`,
       `learnagement`.`INFO_seance_to_be_planned`.`type` AS `type`,
       `learnagement`.`INFO_seance_to_be_planned`.`heure` AS `heure`,
       `learnagement`.`INFO_enseignant`.`nom` AS `nom`,
       `learnagement`.`INFO_enseignant`.`prenom` AS `prenom`,
       group_concat(`learnagement`.`INFO_promo`.`nom_filiere` separator ', ') AS `Filière` 
       from ((((((`learnagement`.`INFO_module` 
	    join `learnagement`.`INFO_module_as_promo` on(`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_module_as_promo`.`id_module`))
            join `learnagement`.`INFO_promo` on(`learnagement`.`INFO_module_as_promo`.`id_promo` = `learnagement`.`INFO_promo`.`id_promo`))
       	    join `learnagement`.`INFO_seance_to_be_planned` on(`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_seance_to_be_planned`.`id_module`)) 
            join `learnagement`.`INFO_parameters_of_views` on(`learnagement`.`INFO_module`.`code_module` = convert(`learnagement`.`INFO_parameters_of_views`.`code_module` using utf8))) 
            join `learnagement`.`INFO_seance_to_be_planned_as_promo` on(`learnagement`.`INFO_seance_to_be_planned`.`id_seance_to_be_planned` = `learnagement`.`INFO_seance_to_be_planned_as_promo`.`id_seance_to_be_planned`)) 
            left join `learnagement`.`INFO_enseignant` on(`learnagement`.`INFO_seance_to_be_planned`.`id_enseignant` = `learnagement`.`INFO_enseignant`.`id_enseignant`)) 
       group by `learnagement`.`INFO_module`.`code_module`,
                `learnagement`.`INFO_module`.`nom`,
                `learnagement`.`INFO_module`.`id_semestre`,
                `learnagement`.`INFO_promo`.`nom_filiere`,
                `learnagement`.`INFO_seance_to_be_planned`.`lieu`,
                `learnagement`.`INFO_seance_to_be_planned`.`lieu`,
                `learnagement`.`INFO_seance_to_be_planned`.`type`,
                `learnagement`.`INFO_seance_to_be_planned`.`heure`,
                `learnagement`.`INFO_enseignant`.`nom`,
                `learnagement`.`INFO_enseignant`.`prenom`;

DROP VIEW IF EXISTS VUE_MCCC;
create view VUE_MCCC as
select `learnagement`.`INFO_module`.`id_module` AS `id_module`,
       `learnagement`.`INFO_module`.`code_module` AS `code_module`,
       `learnagement`.`INFO_module`.`nom` AS `nom`,
       `learnagement`.`INFO_module`.`id_semestre` AS `semestre`,
       `learnagement`.`INFO_module`.`hCM` AS `hCM`,
       `learnagement`.`INFO_module`.`hTD` AS `hTD`,
       `learnagement`.`INFO_module`.`hTP` AS `hTP`,
       `learnagement`.`INFO_module`.`hTPTD` AS `hTPTD`,
       group_concat(`learnagement`.`INFO_promo`.`nom_filiere` separator ', ') AS `filieres`,
       concat(`learnagement`.`INFO_enseignant`.`prenom`,' ',`learnagement`.`INFO_enseignant`.`nom`) AS `responsable`,
       `learnagement`.`INFO_module`.`commentaire` AS `commentaire`
       from (((`learnagement`.`INFO_module`
       	    join `learnagement`.`INFO_module_as_promo` on(`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_module_as_promo`.`id_module`))
       	    join `learnagement`.`INFO_promo` on(`learnagement`.`INFO_module_as_promo`.`id_promo` = `learnagement`.`INFO_promo`.`id_promo`))
       	    join `learnagement`.`INFO_enseignant` on(`learnagement`.`INFO_module`.`id_responsable` = `learnagement`.`INFO_enseignant`.`id_enseignant`))
       where 1
       group by `learnagement`.`INFO_module`.`id_module`;

DROP VIEW IF EXISTS VUE_responsable;
create view VUE_responsable as
select concat(`learnagement`.`INFO_enseignant`.`prenom`,' ',`learnagement`.`INFO_enseignant`.`nom`) AS `responsable`,
       count(`learnagement`.`INFO_module`.`id_module`) AS `responsabilite`,
       group_concat(distinct `learnagement`.`INFO_module`.`code_module` separator ', ') AS `modules`
       from (`learnagement`.`INFO_enseignant`
       	    join `learnagement`.`INFO_module`)
       where `learnagement`.`INFO_module`.`id_responsable` = `learnagement`.`INFO_enseignant`.`id_enseignant`
       group by `learnagement`.`INFO_enseignant`.`nom`,
       	        `learnagement`.`INFO_enseignant`.`prenom`;

DROP VIEW IF EXISTS VUE_resume_charge;
create view VUE_resume_charge as
SELECT *
FROM
    (SELECT sum(`service statutaire`) as "service statutaire", sum(`service effectif`) as "service avec décharge"
	FROM `INFO_enseignant`
	WHERE `statut`="permanent" and `composante`="polytech"
    ) service,
    (SELECT sum(`hCM`*1.5*`nbGroupeCM`) + sum(`hTD`*`nbGroupeTD`) + sum(`hTP`*`nbGroupeTP`) + SUM(`hTPTD`*`nbGroupeTD`) as "charge à couvrir"
	FROM INFO_module
        JOIN INFO_module_as_promo on INFO_module.id_module = INFO_module_as_promo.id_module
        JOIN INFO_promo ON INFO_module_as_promo.id_promo = INFO_promo.id_promo
    ) charge;
