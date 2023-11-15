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


print("<section>"); 

    /*
     * get all modifiable tables
     */
    $tables = mysqli_query($conn, $modifiable_tables_req);
    if (!$tables) {
       echo 'Impossible d\'exécuter la requête : ' . $req;
       echo 'error '.mysqli_error();
       exit;
     }


     /*
      * get each table
      */
     while ($table = mysqli_fetch_row($tables)) {
       print($table[0]);
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
    
?>
