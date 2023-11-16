<?php

    session_start();
    require_once("config.php");
    include("connectDB.php");

if (isset($_POST['table'])) {
  print("prout");
  $responsibleIdsToInsert = getResponsibleIdsToInsert($conn, $_POST['table']);
  
  $fields = [];
  //$values = [];
  $insertAllowed = False;
  $resp = $_POST['id_resp'];
  foreach($_POST as $field => $value){
    if($fields != "table"){
      $fields += [$field => "\"$value\""];
      //array_push($values, "\"$value\"");
      if(!array_key_exists($field, $responsibleIdsToInser)){
	if(in_array($resp, $responsibleIdsToInser[$field])){
	  $insertAllowed = True;
	}
      }
    }
  }

  if($insertAllowed){
    $query = "INSERT INTO " . $_POST['table'] . "(" . implode(" ", array_keys($fields)) . ") VALUES ( " . implode(" ", $fields) . ")";
    mysqli_query($conn, $query);
    header('location: index.php');
  }else{
    print("Insert not allowed!");
  }
}
?>
