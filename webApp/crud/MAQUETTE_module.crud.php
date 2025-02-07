<?php
function deleteMAQUETTE_module($conn, $id) {
    $sql = "DELETE FROM `MAQUETTE_module` WHERE `id`=$id";
    $res = mysqli_query($conn, $sql);
    return $res;
}

function selectMAQUETTE_module($conn, $id) {
    $sql = "SELECT * FROM `MAQUETTE_module` WHERE `id_module`=$id";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res);
    return $rs;
}
function listMAQUETTE_module($conn) {
    $sql = "SELECT * FROM `MAQUETTE_module`";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res);
    return $rs;
}

function listMAQUETTE_moduleByIdResp($conn, $id) {
    $sql = "SELECT * FROM `MAQUETTE_module` WHERE `id_responsable`=$id";
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