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
	  
?>

