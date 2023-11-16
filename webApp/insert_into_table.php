<?php

session_start();
require_once("config.php");
include("connectDB.php");
require_once("functions.php");

if (isset($_POST['table'])) {
  
  $responsibleIdsToInsert = getResponsibleIdsToInsert($conn, $_POST['table']);

 
  dispDict($_POST);
  //dispDict($responsibleIdsToInsert);
  
  $fields = [];
  //$values = [];
  $insertAllowed = false;
  $resp = $_POST['id_responsable'];
  foreach($_POST as $field => $value){
    if($field != "table"){
      $fields += [$field => "\"$value\""];
      //array_push($values, "\"$value\"");
      if(array_key_exists($field, $responsibleIdsToInsert)){
	if(in_array($resp, $responsibleIdsToInsert[$field])){
	  $insertAllowed = true;
	}
      }
    }
  }

  if(!isset($_SESSION['loggedin']) || !$_SESSION['userId'] == $resp){
    $insertAllowed = false;
    print("Insert not allowed: No or bad loggin!");
    exit();
  }
    
  
  if($insertAllowed){
    $query = "INSERT INTO " . $_POST['table'] . "(" . implode(", ", array_keys($fields)) . ") VALUES ( " . implode(", ", $fields) . ")";

    print($query);
    
    mysqli_query($conn, $query);
    header('location: index.php');
  }else{
    print("Insert not allowed: bad responsible!");
  }
}
?>
