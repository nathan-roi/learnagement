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
 /* un bouton pour semestre*/
print("<!DOCTYPE html>
<html lang=\"fr\">
<head>
    <link rel=\"stylesheet\" href=\"style.css\"
    media=\"all\" href=\"<?php echo 'all.css?ver='.'1.2'; ?>\"/>
</head>
<body>


<div class=\"bandeau\">
<div class=\"success\">
  <h1>POLYTECH ANNECY</h1>
 </div>
</div>

<div class=\"campus\"></div>
  <div class=\"overlay\"></div>
  <p class=\"BIENVENUE\">Bienvenue à Learnagement</p>
</div>



<div class=\"paramview\">
  <form action=\"setViewParameters.php\" method=\"post\">
        
    <div class=\"form-group\">
      <div class=\"dropdown\">
        <label for=\"semestre-select\"</label>    
        <select name=\"semestre\" id=\"semestre-select\">
          <option value=''> semestre</option>
        "
);
            
            $sql = "SELECT DISTINCT `semestre` FROM `INFO_module` ORDER BY `INFO_module`.`semestre` ASC";
            $result = mysqli_query($conn, $sql);

            if (mysqli_num_rows($result) > 0) {
                while ($row = mysqli_fetch_assoc($result)) {
                    echo "<option value='" . $row['semestre'] . "'>" . $row['semestre'] . "</option>";
                }
            } else {
                  echo "<option>Aucun semestre trouvé</option>";
              }
   

/*un bouton pour filière*/
  print("
  
     </select>
   </div>
 </div>



        
  <div class=\"form-group\">
    <div class=\"dropdown\">
      <label for=\"filiere-select\"</label>
        <select name=\"filiere\" id=\"filiere-select\">
          <option value=''>filière</option>"
);
            $sql = "SELECT * FROM `INFO_filiere` ORDER BY nom_filiere";
              $result = mysqli_query($conn, $sql);

              if (mysqli_num_rows($result) > 0) {
                  while ($row = mysqli_fetch_assoc($result)) {
                    echo "<option value='" . $row["nom_filiere"] . "'>" . $row["nom_filiere"] . "</option>";
                }
              } else {
                echo "<option>Aucune filière trouvée</option>";
              }
 /*un bouton pour MODULE*/            
  print("       
  
      </select>
    </div>
  </div>
          

  
  
  <div class=\"form-group\">
    <div class=\"dropdown\">
      <label for=\"module-select\"</label>
        <select name=\"module\" id=\"module-select\">
          <option value=''>module</option>"
  );
  $sql = "SELECT * FROM `INFO_module` ORDER BY nom" ;
  $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
       while ($row = mysqli_fetch_assoc($result)) {
        echo "<option value='"  . $row["code"] . "'>" . $row["code"] . " : " . $row["nom"]   . "</option>";
                    
         }
    } else {
          echo "<option>Aucun semestre trouvé</option>";
      }

/*un bouton pour enseignant*/

  print("
                
      </select>
    </div>
</div>
          
<div class=\"form-group\">
    <div class=\"dropdown\">
       <label for=\"enseignant-select\"</label>
          <select name=\"enseignant\" id=\"enseignant-select\">  
            <option value=''>enseignant</option>"

);


$sql = "SELECT * FROM `INFO_enseignant` ORDER BY nom";
       $result = mysqli_query($conn, $sql);

      if (mysqli_num_rows($result) > 0) {
                      
            while ($row = mysqli_fetch_assoc($result)) {
                 echo "<option value='" .  $row["nom"] . "  ". $row["prenom"] . "'>" . $row["nom"] . "  " . $row["prenom"] . "</option>";
            }
      } else {
         echo "<option>Aucun enseignant trouvé</option>";
              }
                   
  

/*
* RECUPERATION DE TOUTES LES VUES (NOM DES TABLES) QUI COMMENCE PAR ...
*/

print("
          </select>
        </div>
      </div>
      <button type=\"submit\" name=\"submit\" value=\"Submit\" class=\"btn-validate\">Valider</button>
    </form>
</div>
");

$req = "SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = 'VIEW' AND TABLE_NAME LIKE 'VUE_%';";
    $views = mysqli_query($conn, $req);
    if (!$views) {
        echo 'Impossible d\'exécuter la requête : ' . $req;
        echo 'error '.mysqli_error($conn);
        exit;
    }
   

/*
* POUR CHAQUE TABLE VUE, ON RECUPERE LA TABLE
*/
print("
      </select>
    </div>
  </div>
</div>");


while ($view = mysqli_fetch_row($views)) {
    $vue_name = $view[0];
   include("get_vue.php");
}


 
 

mysqli_close($conn);
?>


</body>
</html>
