<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");   


// Inclusion des fichiers nécessaires
require_once("db_connection/config.php");
require_once("db_connection/connectDB.php");
require_once("crud/LNM_filiere.crud.php");
require_once("functions.php");

// Connexion à la base de données
$conn = mysqli_connect($mysql_server, $mysql_user, $mysql_passwd, $mysql_db, $mysql_port);

// Vérification de la connexion
if ($conn === FALSE) {
    echo json_encode(["error" => "Connexion à la base de données échouée."]);
    exit;
}

// Récupérer la liste des filières
$filieres = listLNM_filiere($conn);

// Fermer la connexion à la base de données
mysqli_close($conn);

// Retourner les données sous forme de JSON
echo json_encode($filieres);
?>
