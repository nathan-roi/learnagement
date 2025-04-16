<?php
function createLNM_filiere($conn, $id_filiere, $nom_filiere, $nom_long, $id_responsable) {
    $sql = "INSERT INTO `LNM_filiere` (`id_filiere`, `nom_filiere`, `nom_long`, `id_responsable`) VALUES ('$id_filiere', '$nom_filiere', '$nom_long', '$id_responsable')";
    $res = mysqli_query($conn, $sql);
    return $res;
}
function deleteLNM_filiere($conn, $id) {
    $sql = "DELETE FROM `LNM_filiere` WHERE `id`=$id";
    $res = mysqli_query($conn, $sql);
    return $res;
}
function updateLNM_filiere($conn, $id,$id_filiere, $nom_filiere, $nom_long, $id_responsable) {
    $sql = "UPDATE `LNM_filiere` SET `id_filiere`='$id_filiere', `nom_filiere`='$nom_filiere', `nom_long`='$nom_long', `id_responsable`='$id_responsable' WHERE `id` = $id";
    $res = mysqli_query($conn, $sql);
    return $res;
}

// function listLNM_filiere($conn) {
//     $sql = "SELECT * FROM `LNM_filiere`";
//     $res = mysqli_query($conn, $sql);
//     $rs = rs_to_table($res);
//     return $rs;
// }

function listLNM_filiere($conn) {
    // Récupération des filières depuis la base de données
    $sql = "SELECT * FROM `LNM_filiere`";
    $res = mysqli_query($conn, $sql);

    // Vérification des erreurs de la requête
    if (!$res) {
        return ['error' => 'Erreur lors de la récupération des données: ' . mysqli_error($conn)];
    }

    // Transformation du résultat en tableau associatif
    $filieres = [];
    while ($row = mysqli_fetch_assoc($res)) {
        $filieres[] = $row;
    }

    return $filieres;
}


function selectLNM_filiereByUserId($conn, $user_id) {
    $sql = "SELECT * FROM `LNM_filiere` WHERE `id_responsable`=$user_id;";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res);
    return $rs;
}

function selectLNM_filiereByName($conn, $name) {
    $sql = "SELECT * FROM `LNM_filiere` WHERE `nom_filiere`='$name';";
    $res = mysqli_query($conn, $sql);
    $rs = rs_to_table($res)[0];
    return $rs;
}
