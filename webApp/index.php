<?php

/*$servername = "localhost";
$username = "root";
$password = "";
$dbname = "learnagement";
$port = 43306;

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname, $port);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully1";*/
// on va chercher les articles à la base 
include("connectDB.php");
//require_once("config.php");

// Connexion à la base de données'
//$$host = "192.168.143.68";
//$username = "learnagament";
//$password = "tutu";
//$database = "learnagement";

//$conn = mysqli_connect($host, $username, $password, $database);

//if (!$conn) {
    //die("La connexion à la base de données a échoué : " . mysqli_connect_error());


//if (!$conn) {
   // echo "Erreur de connexion à la base de données : " . mysqli_connect_error();
    //exit;

//mysqli_close($conn);
$req = "SELECT * FROM `INFO_vue_parameters` WHERE `sessionId` = '1'";
$result = mysqli_query($conn, $req);

if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $req;
    echo 'error ' . mysqli_error($conn);
    exit;
}

if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $semestre = $row["semestre"];
    $module = $row["module"];
    $enseignant = $row["enseignant"];
} else {
    // Si aucune ligne n'est retournée, définissez les valeurs des paramètres sur des valeurs par défaut ou laissez-les vides
    $semestre = "";
    $module = "";
    $enseignant = "";
}

print("<!DOCTYPE html>
<html lang=\"fr\">
<head>
    <link rel=\"stylesheet\" href=\"style.css\" />
</head>
<body>
<div class=\"success\">
    <h1>Bienvenue!</h1>
    
</div>
<div class=\"paramview\">
    <form action=\"setViewParameters.php\" method=\"post\">
        
        <div class=\"form-group\">
            <label>Semestre</label>
            <input type=\"text\" name=\"semestre\" class=\"form-control\" value=\"$semestre\">
        </div>
        <div class=\"form-group\">
            <label>Module</label>
            <input type=\"text\" name=\"module\" class=\"form-control\" value=\"$module\">
        </div>
        <div class=\"form-group\">
            <label>Enseignant</label>
            <input type=\"text\" name=\"enseignant\" class=\"form-control\" value=\"$enseignant\">
        </div>
        <input type=\"submit\" class=\"btn btn-primary\" name=\"submit\" value=\"Submit\">
    </form>
</div>");


/*
* RECUPERATION DE TOUTES LES VUES (NOM DES TABLES) QUI COMMENCE PAR ...
*/

$req="SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = \"VIEW\" AND TABLE_NAME LIKE \"VUE_%\";";
    $views = mysqli_query($conn, $req);
    if (!$views) {
        echo 'Impossible d\'exécuter la requête : ' . $req;
        echo 'error '.mysqli_error($conn);
        exit;
 }



 /*
* POUR CHAQUE TABLE VUE, ON RECUPERE LA TABLE
*/
     
while ($view = mysqli_fetch_row($views)) {
    $vue_name = $view[0];
   include("get_vue.php");
}






mysqli_close($conn);
?>

</body>
</html>





  
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   