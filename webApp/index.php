<?php
    /*
     * Session initialisation
     */
    session_start();
    require_once("config.php");
    if (isset($_SESSION['start']) && (time() - $_SESSION['start'] > $session_timeout)) {
       session_unset(); 
       session_destroy(); 
       echo "you were disconnected due to a session timeout"; 
    }
    $_SESSION['start'] = time();


    /*
     * Check user connection
     */
    if(!isset($_SESSION["username"])){
        /*header("Location: registration/login.php");
        exit();*/
        $username="anonymous";
	$sessionId = "1";
    }else{
        $username=$_SESSION["username"];
        $sessionId = session_id();
    }

    include("connectDB.php");
    require("requests.php");

    /*
     * get parameters: filters values
     */
    $result = mysqli_query($conn, $param_req);

    if (!$result) {
      echo 'Impossible d\'exécuter la requête : ' . $req;
      echo 'error ' . mysqli_error($conn);
      exit;
    }

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $semestre = $row["semestre"];
        $module = $row["code_module"];
        $enseignant = $row["enseignant"];
        $filiere =  $row["filiere"];
    }else{
        // Si aucune ligne n'est retournée, définissez les valeurs des paramètres sur des valeurs par défaut ou laissez-les vides
        $semestre = "";
        $module = "";
        $enseignant = "";
        $filiere =  "";
    }


    /*
     * display head
     */
    print("<!DOCTYPE html>
        <html lang=\"fr\">
            <head>
                <link rel=\"stylesheet\" href=\"inc/css/style.css\" media=\"all\" href=\"<?php echo 'all.css?ver='.'1.2'; ?>\"/> 
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
    ");


    /*
     * display form of filters
     */

    print("
        <div class=\"paramview\">
            <form action=\"setViewParameters.php\" method=\"post\">
                <input type=\"hidden\" id=\"sessionId\" name=\"sessionId\" value=\"$sessionId\" />
    ");

  /* un bouton pour semestre*/
  print("
    <div class=\"form-group\">
      <div class=\"dropdown\">
        <label for=\"semestre-select\">Semestre :</label>    
        <select name=\"semestre\" id=\"semestre-select\">
          <option value=\"$semestre\" > $semestre </option>
  ");
        
  $sql = "SELECT DISTINCT `semestre` FROM `INFO_module` ORDER BY `INFO_module`.`semestre` ASC";
  $result = mysqli_query($conn, $sql);

  if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
      echo "<option value='" . $row['semestre'] . "'>" . $row['semestre'] . "</option>";
    }
  } else {
    echo "<option>Aucun semestre trouvé</option>";
  }
  print("
         </select>
       </div>
     </div>
  ");


/*un bouton pour filière*/
print("      
  <div class=\"form-group\">
    <div class=\"dropdown\">
      <label for=\"filiere-select\">Filiere :</label>
        <select name=\"filiere\" id=\"filiere-select\">
          <option value='$filiere'>$filiere</option>"
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
      <label for=\"module-select\">Module :</label>
        <select name=\"module\" id=\"module-select\">
          <option value='$module'>$module</option>"
  );
  $sql = "SELECT * FROM `INFO_module` ORDER BY nom" ;
  $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
       while ($row = mysqli_fetch_assoc($result)) {
        echo "<option value='"  . $row["code_module"] . "'>" . $row["code_module"] . " : " . $row["nom"]   . "</option>";
                    
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
       <label for=\"enseignant-select\">Enseignant :</label>
          <select name=\"enseignant\" id=\"enseignant-select\">  
            <option value='$enseignant'>$enseignant</option>"

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
  print("-".implode(" ",$view));
    $vue_name = $view[0];
   include("get_vue.php");
}


 
 

mysqli_close($conn);

      //print(" <script src=\"/inc/js/learnagementScript.js\"></script>");
      print("<script>
 var coll = document.getElementsByClassName(\"collapsible\");
        var i;

        for (i = 0; i < coll.length; i++) {
            coll[i].addEventListener(\"click\", function() {
                this.classList.toggle(\"active\");
                var content = this.nextElementSibling;
                if (content.style.display === \"block\") {
                    content.style.display = \"none\";
                } else {
                    content.style.display = \"block\";
                }
            });
	}
	    </script>");
      
      
?>


</body>
</html>
