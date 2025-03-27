<?php

function selectAPCbyIdComp($conn, $id_competence){
    $sql = "SELECT
            `APC_niveau`.`niveau`,
            `APC_apprentissage_critique`.`id_apprentissage_critique`,
            `APC_apprentissage_critique`.`libelle_apprentissage`,
            `APC_niveau`.`id_competence`,
            `MAQUETTE_module`.`code_module`
            FROM `APC_apprentissage_critique_as_module`
            JOIN `APC_apprentissage_critique` ON `APC_apprentissage_critique_as_module`.`id_apprentissage_critique` = `APC_apprentissage_critique`.`id_apprentissage_critique`
            JOIN `APC_niveau` ON `APC_niveau`.`id_niveau` = `APC_apprentissage_critique`.`id_niveau`
            JOIN `MAQUETTE_module` ON `MAQUETTE_module`.`id_module` = `APC_apprentissage_critique_as_module`.`id_module` 
            WHERE `APC_niveau`.`id_competence` = $id_competence;";

    $res = mysqli_query($conn, $sql);

    return rs_to_table($res);
}


