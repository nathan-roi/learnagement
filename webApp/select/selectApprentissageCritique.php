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

    $firstGroupedData = [];

    // Regrouper par niveau
    foreach ($apprentissage_critiques as $item) {
        $niveau = $item['niveau'];
        if (!isset($firstGroupedData[$niveau])) {
            $firstGroupedData[$niveau] = [];
        }
        $firstGroupedData[$niveau][] = $item;
    }

    $secondGroupedData = [];

    foreach ($firstGroupedData as $niveau => $apprentissages) { // Parcours les niveaux
        foreach ($apprentissages as $apprentissage) { // Parcours chaque apprentissage
            $id_apprentissage = $apprentissage["id_apprentissage_critique"];

            // Création des niveaux et id_apprentissage_critique s'ils n'existent pas
            if (!isset($secondGroupedData[$niveau])) {
                $secondGroupedData[$niveau] = [];
            }
            if (!isset($secondGroupedData[$niveau][$id_apprentissage])) {
                $secondGroupedData[$niveau][$id_apprentissage] = [];
            }

            // Ajout de l'apprentissage dans son groupe
            $secondGroupedData[$niveau][$id_apprentissage][] = $apprentissage;
        }
    }

    echo json_encode($secondGroupedData, JSON_NUMERIC_CHECK);
}
