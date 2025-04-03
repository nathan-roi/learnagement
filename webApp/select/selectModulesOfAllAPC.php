<?php

header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

include("../db_connection/connectDB.php");
include("../crud/function_rs_to_table.php");
include("../crud/APC_apprentissage_critique_as_module.crud.php");


if(isset($_POST["id_user"])){
    $id_user = $_POST["id_user"];
    $modulesOfAllAPC = selectModulesOfAllAPC($conn, $id_user);

    echo json_encode($modulesOfAllAPC, JSON_NUMERIC_CHECK);
}
