<?php
header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

session_start();

include("../db_connection/connectDB.php");
include("../crud/VIEW_display.crud.php");
include("../crud/function_rs_to_table.php");

function removeDuplicatesFromNestedArray($nestedArray)
{
    // Sérialiser les sous-listes pour les rendre uniques
    $serialized = array_map('serialize', $nestedArray);

    // Utiliser array_unique pour supprimer les doublons
    $uniqueSerialized = array_unique($serialized);

    // Désérialiser les sous-listes pour obtenir le résultat original
    $uniqueArray = array_map('unserialize', $uniqueSerialized);

    // Réindexer le tableau pour garantir un encodage JSON correct
    return array_values($uniqueArray);
}

$id_view = $_POST['id_view'];
$code_module = $_POST['code_module'];

$req = selectVIEW_display($conn, $id_view); // on récupère la ligne qui permet d'avoir les dépendances de tout les modules

$sql = $req['request']; // on garde uniquement la requête sql
$sqlFormat = substr($sql, 0, -8) . "WHERE previousModule.`code_module`='" . $code_module . "';"; // WHERE 1; remplacer par le nom du module dont on veut la maquette
$res = mysqli_query($conn, $sqlFormat); // on exécute la nouvelle requête
$rs = rs_to_table($res);

$maquette = removeDuplicatesFromNestedArray($rs); // Suppression des doublons existants
$strMaquette = json_encode($maquette); // Envoie pour le Js

echo $strMaquette;
