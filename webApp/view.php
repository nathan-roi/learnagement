<?php
    /*
     * Session initialisation
     */
  //session_start();
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
    if(!isset($_SESSION["loggedin"])){
        /*header("Location: registration/login.php");
        exit();*/
        $username="anonymous";
	$sessionId = "0";
    }else{
      //$username=$_SESSION["username"];
        $sessionId = session_id();
    }

    include("connectDB.php");
    require("requests.php");

    /*
     * display head
     */
    print("<!DOCTYPE html>
        <html lang=\"fr\">
            <head>
                <link rel=\"stylesheet\" href=\"inc/css/style.css\" media=\"all\" href=\"<?php echo 'all.css?ver='.'1.2'; ?>\"/> 
            </head>
            <body>
    ");
print("<section>");

    $views = mysqli_query($conn, $vues_req);
    if (!$views) {
        echo 'Impossible d\'exécuter la requête : ' . $req;
        echo 'error '.mysqli_error($conn);
        exit;
    }
   

/*
* POUR CHAQUE TABLE VUE, ON RECUPERE LA TABLE
*/

while ($view = mysqli_fetch_row($views)) {
  print("-".implode(" ",$view));
    $vue_name = $view[0];
   include("get_vue.php");
}


mysqli_close($conn);
print("</section>");
	  
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
