<?php
session_start();
require_once("config.php");
require_once("functions_db.php");
require_once("get_view.php");
include("connectDB.php");



if (isset($_SESSION['start']) && (time() - $_SESSION['start'] > $_SESSION['timeout'])) {
  include("logout.php"); 
 }else if(isset($_SESSION['start'])){
  $_SESSION['start'] = time();
 }

$sessionId = session_id();
  


print("<section>");

$views = get_views($conn);

while ($view = mysqli_fetch_row($views)) {
  $view_name = $view[0];
  $request = $view[1];
  $request = sprintf($request, $sessionId);
  //print($request);
  get_view($conn,  $view_name, $request);
}

mysqli_close($conn);
print("</section>");
	  
?>
