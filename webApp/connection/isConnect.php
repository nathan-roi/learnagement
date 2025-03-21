<?php
    include("../functions_filter.php");
    require_once("../db_connection/config.php");
    include("../db_connection/connectDB.php");

    header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
    header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

    header("Content-Type: application/json");

    session_start();

    // Vérifier ou initialiser la session
    if (isset($_SESSION['loggedin'])) {
        echo json_encode($_SESSION);
    } else {
        $_SESSION['loggedin'] = false;
        echo json_encode($_SESSION);
    }


