<?php

    session_start();
    require_once("config.php");
    include("connectDB.php");

if (isset($_POST['table'])) {

  $fields = [];
  $values = [];
  foreach($_POST as $field => $value){
    if($fields != "table"){
      array_push($fields, $field);
      array_push($values, "\"$value\"");
    }
  }
  // CHANGE REQUEST TO UPDATE
  $query = "INSERT INTO " . $_POST['table'] . "(" . implode(" ", $fields) . ") VALUES ( " . implode(" ", $values) . ")";
  print($query);
  mysqli_query($conn, $query);
  header('location: index.php');
}
?>
