<?php
    header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
    header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

    header("Content-Type: application/json");

    session_start();

    include("../db_connection/connectDB.php");
    include("../crud/MAQUETTE_module.crud.php");
    include("../crud/function_rs_to_table.php");

    $id_module = $_POST['id_module'];
    $infosModule = select_infos_module($conn, $id_module);
    $strInfosModule = json_encode($infosModule);

    echo $strInfosModule;
