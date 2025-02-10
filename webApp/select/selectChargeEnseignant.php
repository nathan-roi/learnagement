<?php
header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

session_start();

include("../db_connection/connectDB.php");
include("../crud/function_rs_to_table.php");
include("../crud/VIEW_display.crud.php");

// Fonction générique pour récupérer et filtrer les données d'un enseignant
function chargeEnseignant($conn, $reqId, $userFirstname, $userLastname){
    $req = selectVIEW_display($conn, $reqId)["request"];
    $res = mysqli_query($conn, $req);
    $data = rs_to_table($res);

    // Filtre les résultats en fonction du prénom et nom de l'enseignant
    return array_filter($data, function ($var) use ($userFirstname, $userLastname) {
        return $var["prenom"] == $userFirstname && $var["nom"] == $userLastname;
    });
}

// Fonction qui renvoie la charge d'un enseignant par CM/TD/TP
function chargeRepartiton($conn, $userFirstname, $userLastname){
    return chargeEnseignant($conn, 21, $userFirstname, $userLastname);
}

// Fonction qui renvoie la charge totale de cours d'un enseignant
function chargeTotale($conn, $userFirstname, $userLastname){
    return chargeEnseignant($conn, 22, $userFirstname, $userLastname);
}


if (isset($_POST["userFirstname"]) && isset($_POST["userLastname"])) {

    $userFirstname = $_POST["userFirstname"];
    $userLastname = $_POST["userLastname"];


    $chargeRepartOneEnseignant = chargeRepartiton($conn, $userFirstname, $userLastname);
    $chargeTotaleOneEnseignant = chargeTotale($conn, $userFirstname, $userLastname);

    // Fusionne les résultats de répartition et de charge totale
    $charge = array_merge(
        $chargeTotaleOneEnseignant[array_keys($chargeTotaleOneEnseignant)[0]],
        $chargeRepartOneEnseignant[array_keys($chargeRepartOneEnseignant)[0]]
    );


    echo json_encode($charge);
}else{

    echo json_encode([False, "Error userFirstname or userLastname undefined"]);
}

//if (isset($_POST["user_id"])){
//    $user_id = $_POST["user_id"];
//
//    $sql = "SELECT LNM_enseignant.prenom, LNM_enseignant.nom,
//    SUM(
//    CASE
//    WHEN LNM_seanceType.type = 'CM' THEN MAQUETTE_module_sequencage.duree_h
//    WHEN LNM_seanceType.type = 'TD' THEN MAQUETTE_module_sequencage.duree_h
//    WHEN LNM_seanceType.type = 'TP' THEN MAQUETTE_module_sequencage.duree_h
//    END) AS 'Charge'
//    FROM `MAQUETTE_module`
//    JOIN MAQUETTE_module_sequencage ON MAQUETTE_module_sequencage.id_module = MAQUETTE_module.id_module
//    JOIN MAQUETTE_module_sequence ON MAQUETTE_module_sequence.id_module_sequencage = MAQUETTE_module_sequencage.id_module_sequencage
//    JOIN CLASS_session_to_be_affected ON CLASS_session_to_be_affected.id_module_sequence = MAQUETTE_module_sequence.id_module_sequence
//    JOIN LNM_groupe ON LNM_groupe.id_groupe = CLASS_session_to_be_affected.id_groupe
//    JOIN CLASS_session_to_be_affected_as_enseignant ON CLASS_session_to_be_affected_as_enseignant.id_seance_to_be_affected = CLASS_session_to_be_affected.id_seance_to_be_affected
//    JOIN LNM_enseignant ON LNM_enseignant.id_enseignant = CLASS_session_to_be_affected_as_enseignant.id_enseignant
//    JOIN LNM_seanceType ON LNM_seanceType.id_seance_type = MAQUETTE_module_sequencage.id_seance_type
//    WHERE LNM_enseignant.id_enseignant = $user_id
//    GROUP BY LNM_enseignant.prenom, LNM_enseignant.nom
//    ORDER BY `LNM_enseignant`.`nom` DESC;";
//
//    $res = mysqli_query($conn, $sql);
//    $chargeEnseignant= rs_to_table($res);
//
//
//
//    var_dump($repartOneEnseignant);
//
//    $strCours = json_encode($chargeEnseignant);
//
//    echo $strCours;
//}else{
//    echo json_encode([False, "Error user_id undefined"]);
//}


