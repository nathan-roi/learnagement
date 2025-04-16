<?php

header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

include("../db_connection/connectDB.php");
include("../crud/function_rs_to_table.php");
include("../crud/APC_apprentissage_critique_as_module.crud.php");

session_start();

if(isset($_SESSION["userId"]) && isset($_POST["indexBy"])){
    $id_user = $_SESSION["userId"];
    $indexBy = $_POST["indexBy"];

    $modulesOfAllAPC = selectModulesOfAllAPC($conn, $id_user);
    $modulesOfAllAPCIndex = [];

    foreach ($modulesOfAllAPC as $item) {
        if($indexBy == "id_apprentissage_critique"){
            if(!isset($modulesOfAllAPCIndex[$item["id_apprentissage_critique"]])){
                $modulesOfAllAPCIndex[$item["id_apprentissage_critique"]] = [$item];
            }else{
                $modulesOfAllAPCIndex[$item["id_apprentissage_critique"]][] = $item;
            }
        }elseif ($indexBy == "id_module"){
            if(!isset($modulesOfAllAPCIndex[$item["id_module"]])){
                $modulesOfAllAPCIndex[$item["id_module"]] = [$item];
            }else{
                $modulesOfAllAPCIndex[$item["id_module"]][] = $item;
            }
        }


    }

    echo json_encode($modulesOfAllAPCIndex, JSON_NUMERIC_CHECK);
}
