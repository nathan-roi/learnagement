<?php
header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

session_start();

include("../db_connection/connectDB.php");
include("../crud/VIEW_seance.php");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

if (isset($_POST['input'])) {
    $input = $_POST['input'];

    $duree_h = viewSeance($conn, $input);

    echo json_encode($duree_h);
} else {
    echo json_encode([false, "Error: input undefined"]);
}
?>