DROP VIEW IF EXISTS VUE_module;
create view VUE_module as
select `learnagement`.`INFO_module`.`code_module` AS `code_module`,
       `learnagement`.`INFO_module`.`nom` AS `module`,
       `learnagement`.`INFO_module`.`semestre` AS `semestre`,
       `learnagement`.`INFO_module`.`filiere` AS `filiere`,
       `learnagement`.`INFO_CMTDTP`.`lieu` AS `lieu`,
       `learnagement`.`INFO_CMTDTP`.`type` AS `type`,
       `learnagement`.`INFO_CMTDTP`.`heure` AS `heure`,
       `learnagement`.`INFO_enseignant`.`nom` AS `nom`,
       `learnagement`.`INFO_enseignant`.`prenom` AS `prenom`,
       group_concat(`learnagement`.`INFO_promo`.`nom_filiere` separator ', ') AS `Filière` 
       from (((((`learnagement`.`INFO_module` 
       	    join `learnagement`.`INFO_CMTDTP` on(`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_CMTDTP`.`id_module`)) 
            join `learnagement`.`INFO_vue_parameters` on(`learnagement`.`INFO_module`.`code_module` = convert(`learnagement`.`INFO_vue_parameters`.`code_module` using utf8))) 
            join `learnagement`.`INFO_CMTDTP_as_promo` on(`learnagement`.`INFO_CMTDTP`.`id_CMTDTP` = `learnagement`.`INFO_CMTDTP_as_promo`.`id_CMTDTP`)) 
            join `learnagement`.`INFO_promo` on(`learnagement`.`INFO_CMTDTP_as_promo`.`id_promo` = `learnagement`.`INFO_promo`.`id_promo`)) 
            left join `learnagement`.`INFO_enseignant` on(`learnagement`.`INFO_CMTDTP`.`id_enseignant` = `learnagement`.`INFO_enseignant`.`id_enseignant`)) 
       group by `learnagement`.`INFO_module`.`code_module`,
                `learnagement`.`INFO_module`.`nom`,
                `learnagement`.`INFO_module`.`semestre`,
                `learnagement`.`INFO_module`.`filiere`,
                `learnagement`.`INFO_CMTDTP`.`lieu`,
                `learnagement`.`INFO_CMTDTP`.`lieu`,
                `learnagement`.`INFO_CMTDTP`.`type`,
                `learnagement`.`INFO_CMTDTP`.`heure`,
                `learnagement`.`INFO_enseignant`.`nom`;

DROP VIEW IF EXISTS VUE_MCCC;
create view VUE_MCCC as
select `learnagement`.`INFO_module`.`id_module` AS `id_module`,
       `learnagement`.`INFO_module`.`code_module` AS `code_module`,
       `learnagement`.`INFO_module`.`nom` AS `nom`,
       `learnagement`.`INFO_module`.`semestre` AS `semestre`,
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
       	    join `learnagement`.`INFO_enseignant` on(`learnagement`.`INFO_module`.`id_enseignant` = `learnagement`.`INFO_enseignant`.`id_enseignant`))
       where 1
       group by `learnagement`.`INFO_module`.`id_module`;

DROP VIEW IF EXISTS VUE_responsable;
create view VUE_responsable as
select concat(`learnagement`.`INFO_enseignant`.`prenom`,' ',`learnagement`.`INFO_enseignant`.`nom`) AS `responsable`,
       count(`learnagement`.`INFO_module`.`id_module`) AS `responsabilite`,
       group_concat(distinct `learnagement`.`INFO_module`.`code_module` separator ', ') AS `modules`
       from (`learnagement`.`INFO_enseignant`
       	    join `learnagement`.`INFO_module`)
       where `learnagement`.`INFO_module`.`id_enseignant` = `learnagement`.`INFO_enseignant`.`id_enseignant`
       group by `learnagement`.`INFO_enseignant`.`nom`,
       	        `learnagement`.`INFO_enseignant`.`prenom`;
