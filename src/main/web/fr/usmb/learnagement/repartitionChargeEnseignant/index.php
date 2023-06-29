<?php
    // Initialiser la session
    session_start();
    require_once("config.php");
    if (isset($_SESSION['start']) && (time() - $_SESSION['start'] > $session_timeout)) {
       session_unset(); 
       session_destroy(); 
       echo "you were disconnected due to a session timeout"; 
    }
    $_SESSION['start'] = time();

    // Vérifiez si l'utilisateur est connecté, sinon redirigez-le vers la page de connexion
    if(!isset($_SESSION["username"])){
        /*header("Location: webApp/login.php");
        exit();*/
        $username="anonymous";
    }else{
        $username=$_SESSION["username"];
    }

    require("connectDB.php");
    $sessionId = session_id();
    //print("-".$sessionId.".");



/*
* RECUPERATION DES PARAMETRES
*/

    $req = "SELECT * FROM `INFO_vue_parameters` WHERE `sessionId` =  \"$sessionId\"";
    $result = mysqli_query($conn, $req);
    if (!$result) {
       echo 'Impossible d\'exécuter la requête : ' . $req;
       echo 'error '.mysqli_error();
       exit;
    }
    if (mysqli_num_rows($result) > 0) {
       $row = mysqli_fetch_assoc($result);
       $semestre = $row["semestre"];
       $module = $row["module"];
       $enseignant = $row["enseignant"];
    }else{
            // Si aucune ligne n'est retournée, définissez les valeurs des paramètres sur des valeurs par défaut ou laissez-les vides
            $semestre = "";
            $module = "";
            $enseignant = "";
	}
    


    /*
* FORMULAIRE POUR MODIFIER LES PARAMETRES
*/

    print("<!DOCTYPE html>
        <html lang=\"fr\">
            <head>
                <link rel=\"stylesheet\" href=\"style.css\" />
            </head>
            <body>
                <div class=\"success\">
                    <h1>Bienvenue $username !</h1>
                </div>
                <div class=\"paramview\">
                    <form action=\"setViewParameters.php\" method=\"post\">
		    	<input type=\"hidden\" name=\"sessionId\" value=\"$sessionId\" readonly>
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
                </div>               
    ");



   /*
* RECUPERATION DE TOUTES LES VUES (NOM DES TABLES) QUI COMMENCE PAR ...
*/

    $req="SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = \"VIEW\" AND TABLE_NAME LIKE \"INFO_vue_%\";";
    $views = mysqli_query($conn, $req);
    if (!$views) {
       echo 'Impossible d\'exécuter la requête : ' . $req;
       echo 'error '.mysqli_error();
       exit;
     }


  /*
* POUR CHAQUE TABLE VUE, ON RECUPERE LA TABLE
*/
     /*
     while ($view = mysqli_fetch_row($views)) {
     	   $vue_name = $view[0];
    	   include("get_vue.php");
     }
     require("disconnectDB.php");
   
    //$vue_name = "INFO_vue_resume_heures";
    //include("get_vue.php");

    //$vue_name = "INFO_vue_resume_responsabilite";
    //include("get_vue.php");

    if($username != "anonymous"){
        print("<a href=\"registration/logout.php\">Déconnexion</a>");
    }else{
        print("<a href=\"registration/login.php\">Connexion</a>");
    }

print("
    <script>
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
	</script>
    ");
    
    print("
            </body>
        </html>
    ");
?>*/

// Supposons que vous ayez un tableau contenant les noms des tables vues
$tablesVues = array("vue1", "vue2", "vue3");

// Boucle pour parcourir chaque table vue
foreach ($tablesVues as $vue_name) {
  // Exécutez une requête SELECT pour chaque table vue
  $req = "SELECT * FROM $vue_name";
  $result = mysqli_query($conn, $req);
  
  if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $req;
    echo 'error ' . mysqli_error();
    exit;
  }
  
  // Vérifiez s'il y a des lignes retournées par la requête
  if (mysqli_num_rows($result) > 0) {
    // Boucle pour parcourir chaque ligne de résultat
    while ($row = mysqli_fetch_assoc($result)) {
      // Accédez aux données de la ligne
      $colonne1 = $row['semetre'];
      $colonne2 = $row['module'];
      $colonne3 = $row['enseignant'];
      
      // Faites quelque chose avec les données récupérées (par exemple, les afficher)
      echo "Table : $vue_name - Colonne 1 : $colonne1, Colonne 2 : $colonne2, Colonne 3 : $colonne <br>";
    }
  } else {
    echo "Aucune donnée trouvée pour la table : $vue_name <br>";
  }
  
  // Libérez la mémoire occupée par le résultat de la requête
  mysqli_free_result($result);
}



require("disconnectDB.php");

//$vue_name = "INFO_vue_resume_heures";
//include("get_vue.php");

//$vue_name = "INFO_vue_resume_responsabilite";
//include("get_vue.php");

if ($username != "anonymous") {
    print("<a href=\"registration/logout.php\">Déconnexion</a>");
} else {
    print("<a href=\"registration/login.php\">Connexion</a>");
}

print("
    <script>
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
    </script>
");

print("
    </body>
    </html>
");
