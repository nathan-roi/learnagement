<?php
require("requests.php");
require_once("functions.php");

print("<button type=\"button\" class=\"collapsible\">$table_name</button>");

print("
<article class=\"content\">
      <table>
        <thead>
    ");



/*
 * get the table primary K field 
 */
$primaryK = getPrimaryKeyField($conn, $table_name);
	  

/* 
 * get the table fields
 */

$table = mysqli_query($conn, $columns_table_req);
if (!$table) {
  echo 'Impossible d\'exécuter la requête : ' . $req;
  echo 'error '.mysqli_error();
  exit;
 }

$fields_array = [];
$fields_type = [];
if (mysqli_num_rows($table) > 0) {
  print("<tr>");
  while ($row = mysqli_fetch_row($table)) {
    /*foreach($row as $k=>$v){
      print("$k => $v ");
      }
      print("<br/>");*/
    if($row[3] == $primaryK && !isLinkingTable($conn, $table_name)){
      print(""); // do not display K for base Table (not linking table)
    }else if ($row[3] == "modifiable"){
      print(""); //do not display "modifiable" field
    }else{
      print("<th>".$row[3]."</th>");
    }
    array_push($fields_array, $row[3]);
    array_push($fields_type, $row[7]);
  }
  //$fields = substr($fields, 0, -1);
  $fields = implode(",", $fields_array);
  print("<th>Validation</th>");
  print("</tr></thead>\n");
 }
require("requests.php"); //update requests with required fields
mysqli_free_result($table); // libère l'espace mémoire occupé par le résultat

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
      $psK_values_dic += [$psK_value[0] => implode(" ", array_slice($psK_value, 1))];
    }
    $forefnK_fields_values_dic += [$forefnK[1] => $psK_values_dic];
  }
 }

/*
 * get foreign Ks explicit values: SECONDARY K in reference table
 */


	  
	  
/* 
 * get the table data
 */
print("    <tbody>");
	  
      /*$result  =   mysqli_query($conn, $table_req);  
    
if ($result === FALSE){
  echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysqli_error();
  exit; // inutile de poursuivre le traitement dans ce cas
  } */
      $result = getTableData($conn, $table_name, $fields, $_SESSION['userId']);
    
while($ligne = mysqli_fetch_row ($result)){
  print("<tr>");
  $id_resp=-1;
  $pk = -1;
  $pk0 = -1;
  $pk1 = -1;
  $pk0k = NULL;
  $pk1k = NULL;
  foreach($ligne as $k=>$v){
    
    if(($k == 0) && (!isLinkingTable($conn, $table_name))){
      $pk=$v;
      print("<form id='$table_name$pk' action='update_table.php' method='post' class='form-row'></form>");
      print("<input form='$table_name$pk' type='hidden' name='table' value=\"$table_name\">");
      // save primary key of base table (cannot be modified), tagged with '__old_' to be easily find in the $POST array 
      print("<input form='$table_name$pk' type='hidden' name='__old_$fields_array[$k]' value=\"$v\">");

    }else if(($k == 0) && (isLinkingTable($conn, $table_name))){
	//save old 1st foreign key of primary key for linking table
      $pk0v=$v;      
      $pk0k=$k;      
    }else if((isLinkingTable($conn, $table_name)) && ($k == 1)){
      $pk1v = $v;      
      $pk1k=$k; 
      $pk = $pk0v . "_" . $pk1v;
      
      print("<form id='$table_name$pk' action='update_table.php' method='post' class='form-row'></form>");
      print("<input form='$table_name$pk' type='hidden' name='table' value=\"$table_name\">");
      //save old 1st foreign key of primary key for linking table
      print("<input form='$table_name$pk' type='hidden' name='__old_$fields_array[$pk0k]' value=\"$pk0v\">");
      //save old 2nd foreign key of primary key for linking table
      print("<input form='$table_name$pk' type='hidden' name='__old_$fields_array[$pk1k]' value=\"$pk1v\">");
    }
    // do not display modifiable field
    if($fields_array[$k] == "modifiable"){
      $modifiable = $v;
	    
      // big text fields (cannot be primary or foreign K)
    }else if($fields_type[$k] == "text"){
      print("<td><textarea form='$table_name$pk' name='$fields_array[$k]'>$v</textarea></td>");

      // foreignK
    }else if(in_array($fields_array[$k], $forefnK_fields_array)){
      print("<td><select form='$table_name$pk' name='$fields_array[$k]'>");
      foreach($forefnK_fields_values_dic[$fields_array[$k]] as $key => $value){
	if($key == $v){
	  print("<option selected=\"selected\" value=\"$key\">$value</option>");
	  $id_resp = $key;
	}else{
	  print("<option value=\"$key\">$value</option>");
	}
      }
      print("</select></td>");
    }else if (isLinkingTable($conn, $table_name) || ($k != 0)){ // display other fields except primary key of base table (not linking table)
      print("<td><input form='$table_name$pk' type='text' name='$fields_array[$k]' value=\"$v\"></td>");
    }
  }
  if($modifiable && isset($_SESSION['loggedin']) && $_SESSION['userId'] == $id_resp){
    print("<td><input form='$table_name$pk' type='submit' value='update'></td>");
  }else{
    print("<td><input form='$table_name$pk' type='submit' value='update' disabled></td>");
  }
  print("</tr>\n");
 }


      /*
       * add line to insert new data
       */
print("<tr><form id='" . $table_name . "_insert' action='insert_into_table.php' method='post' class='form-row'></form>");
      print("<input form='" . $table_name . "_insert' type='hidden' name='table' value=\"$table_name\">");
foreach($fields_array as $k=>$v){
  // do not display modifiable field
  if($fields_array[$k] == "modifiable"){
    $modifiable = 0;
	    
    // big text fields
  }else if($fields_type[$k] == "text"){
    print("<td><textarea form='" . $table_name . "_insert' name='$fields_array[$k]'>$v</textarea></td>");

    // foreignK
  }else if(in_array($fields_array[$k], $forefnK_fields_array)){
    print("<td><select form='" . $table_name . "_insert' name='$fields_array[$k]'>");
    print("<option value=\"$fields_array[$k]\">$fields_array[$k]</option>");
    foreach($forefnK_fields_values_dic[$fields_array[$k]] as $key => $value){
      print("<option value=\"$key\">$value</option>");
    }
    print("</select></td>");
	      
    // primaryK
  }else if($k == 0){
    //print("<input form='" . $table_name . "_insert' type='hidden' name='$fields_array[$k]' value=\"$v\">");
    print(""); // primary K is autoincremented
    // others
  }else{
    print("<td><input form='" . $table_name . "_insert' type='text' name='$fields_array[$k]' value=\"$v\"></td>");
  }
}
print("<td><input form='" . $table_name . "_insert' type='submit' value='insert'></td>");
print("</tr>\n");
print("    </tbody>");
mysqli_free_result($result); // libère l'espace mémoire occupé par le résultat
    
print("</table>
</article>");
?>   
