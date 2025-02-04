<?php
header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

session_start();

include("../db_connection/connectDB.php");
include("../crud/function_rs_to_table.php");


if (isset($_POST["user_id"])){
    $user_id = $_POST["user_id"];

    $sql = "SELECT LNM_enseignant.prenom, LNM_enseignant.nom, 
    SUM(
    CASE 
    WHEN LNM_seanceType.type = 'CM' THEN MAQUETTE_module_sequencage.duree_h 
    WHEN LNM_seanceType.type = 'TD' THEN MAQUETTE_module_sequencage.duree_h
    WHEN LNM_seanceType.type = 'TP' THEN MAQUETTE_module_sequencage.duree_h 
    END) AS 'Charge'
    FROM `MAQUETTE_module` 
    JOIN MAQUETTE_module_sequencage ON MAQUETTE_module_sequencage.id_module = MAQUETTE_module.id_module
    JOIN MAQUETTE_module_sequence ON MAQUETTE_module_sequence.id_module_sequencage = MAQUETTE_module_sequencage.id_module_sequencage
    JOIN CLASS_session_to_be_affected ON CLASS_session_to_be_affected.id_module_sequence = MAQUETTE_module_sequence.id_module_sequence
    JOIN LNM_groupe ON LNM_groupe.id_groupe = CLASS_session_to_be_affected.id_groupe
    JOIN CLASS_session_to_be_affected_as_enseignant ON CLASS_session_to_be_affected_as_enseignant.id_seance_to_be_affected = CLASS_session_to_be_affected.id_seance_to_be_affected
    JOIN LNM_enseignant ON LNM_enseignant.id_enseignant = CLASS_session_to_be_affected_as_enseignant.id_enseignant
    JOIN LNM_seanceType ON LNM_seanceType.id_seance_type = MAQUETTE_module_sequencage.id_seance_type
    WHERE LNM_enseignant.id_enseignant = $user_id
    GROUP BY LNM_enseignant.prenom, LNM_enseignant.nom
    ORDER BY `LNM_enseignant`.`nom` DESC;";

    $res = mysqli_query($conn, $sql);
    $chargeEnseignant= rs_to_table($res);

    $strCours = json_encode($chargeEnseignant);

    echo $strCours;
}else{
    echo json_encode([False, "Error user_id undefined"]);
}


