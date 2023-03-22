<?php
 require_once("config.php");
 $conn = mysqli_connect("tp-epua.univ-savoie.fr","$mysql_user","$mysql_passwd","$mysql_user",3308);

   if  ($conn === FALSE){
     echo "connexion au serveur impossible: ".myslq_error();
     exit;
   }
   mysqli_query($conn, 'SET NAMES utf8');
?>
