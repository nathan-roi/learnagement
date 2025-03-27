<?php

header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

include("../db_connection/connectDB.php");
include("../crud/function_rs_to_table.php");
include("../crud/APC_apprentissage_critique_as_module.crud.php");

if (isset($_POST["idCompetence"])) {
    $idCompetence = $_POST["idCompetence"];
    $apprentissage_critiques = selectAPCbyIdComp($conn, $idCompetence);

    $groupedData = [];

    // Regrouper par niveau
    foreach ($apprentissage_critiques as $item) {
        $niveau = $item['niveau'];
        if (!isset($groupedData[$niveau])) {
            $groupedData[$niveau] = [];
        }
        $groupedData[$niveau][] = $item;
    }

    echo json_encode($groupedData, JSON_NUMERIC_CHECK);
}
