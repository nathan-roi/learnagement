<?php
function createMAQUETTE_dependance_sequence($conn, $id_sequence_prev, $id_sequence_next, $id_responsable, $modifiable) {
    $sql = "INSERT INTO `MAQUETTE_dependance_sequence` (`id_sequence_prev`, `id_sequence_next`, `id_responsable`, `modifiable`) VALUES ('$id_sequence_prev', '$id_sequence_next', '$id_responsable', '$modifiable')";
    $res = mysqli_query($conn, $sql);
    return $res;
}
function deleteMAQUETTE_dependance_sequence($conn, $id) {
    $sql = "DELETE FROM `MAQUETTE_dependance_sequence` WHERE `id`=$id";
    $res = mysqli_query($conn, $sql);
    return $res;
}

function updateMAQUETTE_dependance_sequence($conn, $id,$id_sequence_prev, $id_sequence_next, $id_responsable, $modifiable) {
    $sql = "UPDATE `MAQUETTE_dependance_sequence` SET `id_sequence_prev`='$id_sequence_prev', `id_sequence_next`='$id_sequence_next', `id_responsable`='$id_responsable', `modifiable`='$modifiable' WHERE `id` = $id";
    $res = mysqli_query($conn, $sql);
    return $res;
}
function listMAQUETTE_dependance_sequence($conn) {
    $sql = "SELECT * FROM `MAQUETTE_dependance_sequence`";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res);
    return $rs;
}
