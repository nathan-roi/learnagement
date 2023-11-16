<?php
  /* 
   * get the table primary K field
   */
function getPrimaryKeyField($conn, $table_name){
  
  $primaryKeyField_req = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'learnagement' AND COLUMN_KEY = 'PRI' AND table_name = \"$table_name\"";


    $table = mysqli_query($conn, $primaryKeyField_req);
    if (!$table) {
        echo 'Impossible d\'exécuter la requête : ' . $req;
        echo 'error '.mysqli_error();
        exit;
    }

    /*
     * get K
     */
    if (mysqli_num_rows($table) > 0) {
      $primaryK = mysqli_fetch_row($table)[0];
    }

    mysqli_free_result($table); // libère l'espace mémoire occupé par le résultat

    return $primaryK;
  }

function getSecondaryKs($table){
    require_once("config.php");
  $table_name = $table;
  require("requests.php");

  /*
   * get the table foreign Ks 
   */
  $forefnK_fields_array = [];
  $forefnK_fields_values_dic = [];
  $forefnKs = mysqli_query($conn, $foreignK_req);
  if (!$forefnKs) {
    echo 'Impossible d\'exécuter la requête : ' . $req;
    echo 'error '.mysqli_error();
    exit;
  }
  if (mysqli_num_rows($forefnKs) > 0) {
    while ($forefnK = mysqli_fetch_row($forefnKs)) {
      array_push($forefnK_fields_array, $forefnK[1]);
      $reference_table_name = $forefnK[3];
      require("requests.php"); //update requests with required reference_table_name

      $primaryk_and_secondaryK = mysqli_query($conn, $secondaryk_fields_req);
      $primaryk_and_secondaryK =  implode(", ",mysqli_fetch_row($primaryk_and_secondaryK));
  
      require("requests.php"); //update requests with required primaryk_and_secondaryK
      $primaryk_and_secondaryK_values = mysqli_query($conn, $secondaryk_values_req);
      $psK_values_dic = [];
      while ($psK_value = mysqli_fetch_row($primaryk_and_secondaryK_values)) {
	$psK_values_dic += [$psK_value[0] => implode(" ", array_slice($psK_value, 1))]; // add dictionary entry: primaryK => secondaryK
      }
      $forefnK_fields_values_dic += [$forefnK[1] => $psK_values_dic];
    }
  }
  return $forefnK_fields_values_dic;
}

?>
