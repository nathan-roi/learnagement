<?php

    session_start();
    require_once("config.php");
    include("connectDB.php");
include("functions.php");

if (isset($_POST['table'])) {

  $pk = getPrimaryKeyField($conn, $_POST['table']);
  
  $updates = [];
  foreach($_POST as $field => $value){
    if($field != "table" && $field != $pk){
      if(empty($value)){
	array_push($updates, $field . " = NULL");
      }else{
	array_push($updates, $field . " = \"$value\"");
      }
    }
  }
  $query = "UPDATE " . $_POST['table'] . " SET " . implode(", ", $updates) . " WHERE " . $pk . " = " . $_POST[$pk];
  mysqli_query($conn, $query);
  header('location: index.php');
}
?>
