<?php
header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");


include("../db_connection/connectDB.php");
include("../crud/MAQUETTE_module.crud.php");
include("../crud/function_rs_to_table.php");

session_start();


$id = $_SESSION['userId'];
$listeModules = listMAQUETTE_moduleByIdResp($conn, $id);
$strlisteModules = json_encode($listeModules);

echo $strlisteModules;
