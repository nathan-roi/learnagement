<?php
header("Access-Control-Allow-Origin: http://localhost:40080"); // Activer CORS
header("Access-Control-Allow-Credentials: true"); // Autoriser le partage de cookies


// On demarre la session
session_start ();

session_regenerate_id(true);

// On détruit notre session
session_destroy ();

