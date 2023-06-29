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
    }else{
        $username=$_SESSION["username"];
    }

    /*
     * db connection and load requests
     */
    require("connectDB.php");
    $sessionId = session_id();
    //print("-".$sessionId.".");

    require("requests.php");



    /*
     * get parameters: filters values
     */
    $result = mysqli_query($conn, $param_req);
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


    /*
     * display form of filters
     */
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


    /*
     * get all tables
     */
    $views = mysqli_query($conn, $tables_req);
    if (!$views) {
       echo 'Impossible d\'exécuter la requête : ' . $req;
       echo 'error '.mysqli_error();
       exit;
     }

     /*
      * get each table
      */
     while ($table = mysqli_fetch_row($views)) {
     	   $table_name = $table[0];
    	   include("get_table.php");
     }


     /*
      * disconnect db
      */
     require("disconnectDB.php");


    /*
     * diconect user
     */
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
