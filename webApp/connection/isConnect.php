<?php
    session_start();

    header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
    header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

    header("Content-Type: application/json");

    // Vérifier ou initialiser la session
    if (isset($_SESSION['loggedin'])) {
        echo json_encode($_SESSION);
    } else {
        $_SESSION['loggedin'] = false;
        echo json_encode($_SESSION);
    }

