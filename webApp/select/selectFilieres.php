<?php
header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies

header("Content-Type: application/json");

session_start();
include("../db_connection/connectDB.php");
include("../crud/VIEW_display.crud.php");
include("../crud/function_rs_to_table.php");
include("../functions_filter.php");

$request = selectVIEW_display($conn, 4)["request"];
$request = __addFiltersInRequest($conn, $request);

$result = mysqli_query($conn, $request);
$result = rs_to_table($result);

echo json_encode($result, JSON_NUMERIC_CHECK);

