<?php
 require_once("config.php");
 // Create connection
 $conn = new mysqli($mysql_host, $mysql_user, $mysql_passwd, $dbname, $port);

 //$conn = mysqli_connect("tp-epua.univ-savoie.fr","$mysql_user","$mysql_passwd","$mysql_user",3308);

   if  ($conn->connect_error){
     echo "connexion au serveur impossible: ".mysqli_error($conn);
     exit;
   }
   mysqli_query($conn, 'SET NAMES utf8');
?>
