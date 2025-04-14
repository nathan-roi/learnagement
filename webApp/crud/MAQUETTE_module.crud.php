<?php
function deleteMAQUETTE_module($conn, $id) {
    $sql = "DELETE FROM `MAQUETTE_module` WHERE `id`=$id";
    $res = mysqli_query($conn, $sql);
    return $res;
}

function select_infos_module($conn, $id) {
    $sql = "SELECT * FROM `MAQUETTE_module` WHERE `id_module`=$id";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res);

    return $rs[0];
}

function selectMAQUETTE_module($conn, $code_module) {
    $sql = "
        SELECT 
            previousModule.`code_module` as 'module précédent', 
            CONCAT(previousSeanceType.`type`, previousSequences.`numero_ordre`) as 'séance précédente',
            nextModule.`code_module` as 'module suivant',
            CONCAT(nextSeanceType.`type`, nextSequences.`numero_ordre`) as 'séance suivante'

        FROM `MAQUETTE_dependance_sequence` 
        
        JOIN `MAQUETTE_module_sequence` previousSequences ON previousSequences.`id_module_sequence` = `MAQUETTE_dependance_sequence`.`id_sequence_prev` 
        JOIN `MAQUETTE_module_sequencage` previousSequencages ON previousSequencages.`id_module_sequencage` = previousSequences.`id_module_sequencage`
        JOIN `MAQUETTE_module` previousModule ON previousModule.`id_module` = previousSequencages.`id_module` 
        JOIN `LNM_seanceType` previousSeanceType ON previousSeanceType.id_seance_type = previousSequencages.`id_seance_type`
        
        JOIN `MAQUETTE_module` ON `MAQUETTE_module`.`id_module` = previousModule.`id_module`
        JOIN `LNM_semestre` ON `LNM_semestre`.`id_semestre` = `MAQUETTE_module`.`id_semestre`
        
        JOIN `MAQUETTE_module_sequence` nextSequences ON nextSequences.`id_module_sequence` = `MAQUETTE_dependance_sequence`.`id_sequence_next`  
        JOIN `MAQUETTE_module_sequencage` nextSequencages ON nextSequencages.`id_module_sequencage` = nextSequences.`id_module_sequencage`
        JOIN `MAQUETTE_module` nextModule ON nextModule.`id_module` = nextSequencages.`id_module` 
        JOIN `LNM_seanceType` nextSeanceType ON nextSeanceType.id_seance_type = nextSequencages.`id_seance_type`
        
        JOIN `MAQUETTE_module_as_learning_unit` ON `MAQUETTE_module_as_learning_unit`.`id_module` = `MAQUETTE_module`.`id_module`
        JOIN `MAQUETTE_learning_unit` ON `MAQUETTE_learning_unit`.`id_learning_unit` = `MAQUETTE_module_as_learning_unit`.`id_learning_unit`
        JOIN `LNM_promo` ON `MAQUETTE_learning_unit`.`id_promo` = `LNM_promo`.`id_promo`
        JOIN `LNM_statut` ON `LNM_statut`.`id_statut` = `LNM_promo`.`id_statut`
        JOIN `LNM_filiere` ON `LNM_filiere`.`id_filiere` = `LNM_promo`.`id_filiere`
        JOIN `MAQUETTE_discipline` ON `MAQUETTE_discipline`.`id_discipline` = `MAQUETTE_module`.`id_discipline`
        
        WHERE previousModule.`code_module`='$code_module'";

    $res = mysqli_query($conn, $sql);
    return rs_to_table($res);
}


function listMAQUETTE_module($conn) {
    $sql = "SELECT * FROM `MAQUETTE_module`";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res);
    return $rs;
}

function listMAQUETTE_moduleByIdResp($conn, $id) {
    $sql = "SELECT * FROM `MAQUETTE_module` WHERE `id_responsable`='$id'";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res);
    return $rs;
}

function createMAQUETTE_module($conn, $id_module, $code_module, $nom, $ECTS, $id_discipline, $id_semestre, $hCM, $hTD, $hTP, $hTPTD, $hPROJ, $hPersonnelle, $id_responsable, $id_etat_module, $commentaire, $modifiable) {
    $sql = "INSERT INTO `MAQUETTE_module` (`id_module`, `code_module`, `nom`, `ECTS`, `id_discipline`, `id_semestre`, `hCM`, `hTD`, `hTP`, `hTPTD`, `hPROJ`, `hPersonnelle`, `id_responsable`, `id_etat_module`, `commentaire`, `modifiable`) VALUES ('$id_module', '$code_module', '$nom', '$ECTS', '$id_discipline', '$id_semestre', '$hCM', '$hTD', '$hTP', '$hTPTD', '$hPROJ', '$hPersonnelle', '$id_responsable', '$id_etat_module', '$commentaire', '$modifiable')";
    $res = mysqli_query($conn, $sql);
    return $res;
}

function updateMAQUETTE_module($conn, $id,$id_module, $code_module, $nom, $ECTS, $id_discipline, $id_semestre, $hCM, $hTD, $hTP, $hTPTD, $hPROJ, $hPersonnelle, $id_responsable, $id_etat_module, $commentaire, $modifiable)
{
    $sql = "UPDATE `MAQUETTE_module` SET `id_module`='$id_module', `code_module`='$code_module', `nom`='$nom', `ECTS`='$ECTS', `id_discipline`='$id_discipline', `id_semestre`='$id_semestre', `hCM`='$hCM', `hTD`='$hTD', `hTP`='$hTP', `hTPTD`='$hTPTD', `hPROJ`='$hPROJ', `hPersonnelle`='$hPersonnelle', `id_responsable`='$id_responsable', `id_etat_module`='$id_etat_module', `commentaire`='$commentaire', `modifiable`='$modifiable' WHERE `id` = $id";
    $res = mysqli_query($conn, $sql);
    return $res;
}