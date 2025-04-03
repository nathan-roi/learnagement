<?php

function selectModulesOfAllAPC($conn, $id_user){
    $sql = "SELECT 
                `id_apprentissage_critique`,
                `MAQUETTE_module`.`id_module`,
                `MAQUETTE_module`.`code_module`,
                `MAQUETTE_module`.`nom`
            FROM `APC_apprentissage_critique_as_module`
            JOIN `MAQUETTE_module` ON `APC_apprentissage_critique_as_module`.`id_module` = `MAQUETTE_module`.`id_module`
            WHERE `MAQUETTE_module`.`id_responsable` = $id_user;";

    $res = mysqli_query($conn, $sql);

    return rs_to_table($res);
}
