<?php
    /*
     * Session initialisation
     */
    session_start();
    require_once("config.php");

if(isset($_SESSION['loggedin'])){
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
    require_once("functions_db.php");
    require_once("get_data.php");
    require("connectDB.php");

    
    $sessionId = session_id();
    //print("-".$sessionId.".");

    //require("requests.php");

    print("<section>");

    $updatables = get_updatables($conn);

    while ($table = mysqli_fetch_row($updatables)) {
      $table_name = $table[0];
      $request = $table[1];
      $request = sprintf($request, $sessionId);
      print($request);
      get_updatable($conn,  $table_name, $request);
    }
    
    mysqli_close($conn);
    print("</section>");
    
 }else{
  header('location: login.php');
 }
?>
