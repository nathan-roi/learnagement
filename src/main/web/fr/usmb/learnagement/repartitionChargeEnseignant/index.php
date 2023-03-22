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
        /*header("Location: registration/login.php");
        exit();*/
        $username="anonymous";
    }else{
        $username=$_SESSION["username"];
    }

    require("connectDB.php");
    $sessionId = session_id();
    //print("-".$sessionId.".");
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
	if(!isset($semestre)){
	       $semestre = "";
       	       $module = "";
       	       $enseignant = "";
	}
    }


    print("<!DOCTYPE html>
        <html lang=\"fr\">
            <head>
                <link rel=\"stylesheet\" href=\"style.css\" />
            </head>
            <body>
                <div class=\"sucess\">
                    <h1>Bienvenue $username !</h1>
                </div>
                <div class=\"paramview\">
                    <form action=\"setViewParameters.php\" method=\"post\">
		    	<input type=\"hidden\" name=\"sessionId\" value=\"$sessionId\" readonly>
                        <div class=\"form-group\">
                            <label>Semestre</label>
                            <input type=\"text\" name=\"semestre\" class=\"form-control\" value=$semestre>
                        </div>
                        <div class=\"form-group\">
                            <label>Module</label>
                            <input type=\"text\" name=\"module\" class=\"form-control\" value=$module>
                        </div>
                        <div class=\"form-group\">
                            <label>Enseignant</label>
                            <input type=\"text\" name=\"enseignant\" class=\"form-control\" value=$enseignant>
                        </div>
                        <input type=\"submit\" class=\"btn btn-primary\" name=\"submit\" value=\"Submit\">
                    </form>
                </div>               
    ");


    $req="SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = \"VIEW\" AND TABLE_NAME LIKE \"INFO_vue_%\";";
    $views = mysqli_query($conn, $req);
    if (!$views) {
       echo 'Impossible d\'exécuter la requête : ' . $req;
       echo 'error '.mysqli_error();
       exit;
     }
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
?>