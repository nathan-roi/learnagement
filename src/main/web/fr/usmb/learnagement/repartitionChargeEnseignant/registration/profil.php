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
        header("Location: registration/login.php");
        exit();
    }else{
        $username=$_SESSION["username"];
    }

    require("connectDB.php");
    $sessionId = session_id();
    
    $req = "SELECT * FROM `INFO_enseignant` WHERE `sessionId` =  \"$username\"";
    $result = mysqli_query($conn, $req);
    if (!$result) {
       echo 'Impossible d\'exécuter la requête : ' . $req;
       echo 'error '.mysqli_error();
       exit;
    }
    if (mysqli_num_rows($result) > 0) {
       $row = mysqli_fetch_assoc($result);
       $prenom = $row["prenom"];
       $nom = $row["nom"];
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
                <div class=\"sucess\">
                    <form action=\"saveProfile.php\" method=\"get\" class=\"form-example\">
  			<label for=\"Prenom\">Prénom : </label>
    			<input type=\"text\" name=\"prenom\" id=\"prenom\" value=\"$prenom\" required>
  			<label for=\"nom\">Nom : </label>
    			<input type=\"text\" name=\"name\" id=\"name\" value=\"$nom\" required>
    			<input type=\"submit\" value=\"Subscribe!\">
		    </form>
                </div>
           </body>
      </html>")
?>
