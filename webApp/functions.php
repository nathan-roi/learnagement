<?php
    require_once("config.php");

 /**
   * get the table primary K fields
   *
   * @param
   *
   * @param string $table_name table 
   *
   * @return array Return the primary key as array of string
   */
function getPrimaryKeyFields($conn, $table_name){

  global $mysql_db;
  
  $primaryKeyField_req = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = \"$mysql_db\" AND COLUMN_KEY = 'PRI' AND table_name = \"$table_name\"";

  $table = mysqli_query($conn, $primaryKeyField_req);
  if (!$table) {
    echo 'Impossible d\'exécuter la requête : ' . $req;
    echo 'error '.mysqli_error();
    exit;
  }

  /*
   * get K
   */
  $primaryKFields = [];
  if (mysqli_num_rows($table) > 0) {
    while($fieldRow = mysqli_fetch_row($table)){
      array_push($primaryKFields, $fieldRow[0]);
    }
  }

  mysqli_free_result($table); // free result memory space

  return $primaryKFields;
  }


  /**
   * @deprecated get the table primary K field (use getPrimaryKeyFields instead)
   *
   * @param
   *
   * @param string $table_name table 
   *
   * @return string Return the primary key
   */
function getPrimaryKeyField($conn, $table_name){

  return getPrimaryKeyFields($conn, $table_name)[0];
}

/**
   * get the table primary K values
   *
   * @param
   *
   * @param string $table_name table 
   *
   * @return array Return the primary key values as array of string
   */
function getPrimaryKeyValues($conn, $table_name){
  $primaryKFields = implode( ", ", getPrimaryKeyFields($conn, $table_name));
  
  $primaryKeyValues_req = "SELECT $primaryKFields FROM $table_name";
  $result = mysqli_query($conn, $primaryKeyValues_req);
  if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $primaryKeyValues_req;
    echo 'error '.mysqli_error();
    exit;
  }
  $primaryKeyValues = [];
  if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_row($result)) {
      array_push($primaryKeyValues,$row[0]);
    }
  }
  return $primaryKeyValues;
}


/**
 * NOT USE YET
 */
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

/**
 * return explicit secondary K values as a string for a given primary K.
 */
function getSecondaryKeyValue($conn, $reference_table_name, $primary_value){

  global $mysql_db;

  // get primary K fields
  $primaryKFields = getPrimaryKeyFields($conn, $reference_table_name);
  // Theoriticaly there is only one field
  
  //get foreign Ks fields
  $foreignKsFields = getForeignKeys($conn, $reference_table_name);
   
  // get secondary K fields
  $secondaryk_fields_req = "SELECT column_name FROM information_schema.statistics WHERE table_schema = \"$mysql_db\" AND table_name = \"$reference_table_name\" AND INDEX_NAME = \"SECONDARY\"";

  $result = mysqli_query($conn, $secondaryk_fields_req);

  $secondaryKFields = [];
  if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_row($result)) {
      array_push($secondaryKFields, $row[0]);
    }
  }
    
  $secondaryKString = implode(", ", $secondaryKFields);
    
  // get secondary K values
  $secondaryk_values_req = "SELECT $secondaryKString FROM $reference_table_name WHERE $primaryKFields[0] = \"$primary_value\"";
  
  $result = mysqli_query($conn, $secondaryk_values_req);
  $secondaryKValues = [];
  if (mysqli_num_rows($result) > 0) {
    $secondaryKValues = mysqli_fetch_row($result); //get secondary K values of given primary K
  }
  
  foreach($secondaryKFields as $index => $secondaryKField){
    if (in_array($secondaryKField, array_keys($foreignKsFields))){
      $secondaryKValues[$index] = getSecondaryKeyValue($conn, $foreignKsFields[$secondaryKField], $secondaryKValues[$index]);
    }
  }
  
  return implode(", ", $secondaryKValues);
}

/**
 * return explicit secondary K values for all primary Ks as dictionary primaryKValue => secondaryKvalue.
 */
function getPrimarySecondaryKeyValues($conn, $reference_table_name){

  $primaryKValues = getPrimaryKeyValues($conn, $reference_table_name);
  
  $primarySecondaryKeyValues = [];
  foreach($primaryKValues as $primaryKValue){
    $primarySecondaryKeyValues[$primaryKValue] = getSecondaryKeyValue($conn, $reference_table_name, $primaryKValue);
  }
  return $primarySecondaryKeyValues;
}

/**
 * @return array Return the dictionnary FK => table of reference for a given table
 */
function getForeignKeys($conn, $table_name){

  global $mysql_db;

  $foreignK_req = "SELECT TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_SCHEMA = \"$mysql_db\" AND TABLE_NAME = \"$table_name\"";

  $result = mysqli_query($conn, $foreignK_req);
  if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $foreignK_req;
    echo 'error '.mysqli_error();
    exit;
  }

  $foreignKeys = [];
  if (mysqli_num_rows($result) > 0) {
    while ($foreignKey = mysqli_fetch_row($result)) {
      $foreignKeys += [$foreignKey[1] => $foreignKey[3]]; // add entry FK => ref table
    }
  }
  return $foreignKeys;
}

/**
 *
 */
function getFields($conn, $table_name){
  $fieldsName_req = "SHOW COLUMNS FROM $table_name";

  $result = mysqli_query($conn, $fieldsName_req);
  
  if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $foreignK_req;
    echo 'error '.mysqli_error();
    exit;
  }

  $fields = [];
  if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_row($result)) {
      array_push($fields, $row[0]);
    }
  }
  return $fields;
}


function getTableData($conn, $table_name, $fields, $id_responsable){
  // get table content
  $table_req = " SELECT $fields FROM  $table_name WHERE id_responsable='$id_responsable' ";

$result  =   mysqli_query($conn, $table_req);  
    
if ($result === FALSE){
  echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysqli_error();
  exit; // inutile de poursuivre le traitement dans ce cas
 }

 return $result;
  
}

/**
 *
 */
function getKeysValuesResponsibles($conn, $table_name){

  global $mysql_db;

  $fields = getFields($conn, $table_name);

  //dispDict($fields);
  
  $keysValuesResponsibles = [];
  if(in_array("id_responsable", $fields)){
  
      $primaryKeyField = getPrimaryKeyField($conn, $table_name); // string of primary key field

      //$secondaryKeyFields = getSecondaryKeyFields($conn, $table_name); // array of string of secondary key fields
      
      $keysValuesResponsibles_req = "SELECT $primaryKeyField , id_responsable FROM $table_name";

      $result = mysqli_query($conn, $keysValuesResponsibles_req);
      if (!$result) {
	echo 'Impossible d\'exécuter la requête : ' . $keysValuesResponsibles_req;
	echo 'error '.mysqli_error();
	exit;
      }
  
      
      if (mysqli_num_rows($result) > 0) {
	while ($row = mysqli_fetch_row($result)) {
	  
 
	  //dispDict($row);
	  $keysValuesResponsibles += [$row[0] => $row[1]]; // add entry FK => ref table
	}
      }
    }
    return $keysValuesResponsibles;
}

/**
 *
 *
 * reurn a dictionary  foreignK => id_responsible
 */
function getResponsibleIdsToInsert($conn, $table_name){

  $foreignKeys = getForeignKeys($conn, $table_name);

  //dispDict($foreignKeys);

  $inheritenceResponsability = [];
  foreach($foreignKeys as $foreignKey => $table){
    $keysValuesResponsibles = getKeysValuesResponsibles($conn, $table);
    //print("$foreignKey => $table :</br>");
    //dispDict($keysValuesResponsibles);
    if(!empty($keysValuesResponsibles)){
      $inheritenceResponsability += [ $foreignKey => $keysValuesResponsibles];
    }
  }
  return  $inheritenceResponsability;
}


/**
 *
 *
 * @return Boolean Return true if the table is a linking table (more than one field in the primary key)
 */
function isLinkingTable($conn, $table_name){
  $primayK = getPrimaryKeyFields($conn, $table_name);

  return count($primayK) > 1;
}

function dispDict($d){
  //return(0); //comment to debug, uncomment for prod
  print("</br></br>");
  foreach($d as $k => $v){
    if(gettype($v) == "string")
      print($k . "=>" . $v ."</br>\n");
    else if(gettype($v) == "array")
      print($k . "=>" . dispDict($v) ."</br>\n");
  }debug_print_backtrace();
}


/**
 *
 */
function initFilter($conn, $userId, $sessionId){

  if($userId != "NULL"){
    $userId = "\"" . $userId . "\"";
  }
  
  $req = "INSERT INTO `INFO_parameters_of_views` (`id_parameters_of_views`, `userId`, `sessionId`, `id_semestre`, `code_module`, `fullname`, `nom_filiere`) VALUES (NULL," . $userId . ",\"" . $sessionId . "\",NULL,NULL,NULL, NULL )";

  //print($req);
  $result = mysqli_query($conn, $req);

  if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $req;
    echo 'error ' . mysqli_error($conn);
    exit;
  }
}
?>
