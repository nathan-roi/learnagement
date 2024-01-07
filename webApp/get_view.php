<?php

require_once("functions.php");

/*
 * return array of table names extracted from SQL request
 */
function __getTableFromRequest($conn, $request){
  
  $req = "EXPLAIN " . $request;
  $result = mysqli_query($conn, $req);

  if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $req;
    echo 'error ' . mysqli_error($conn);
    exit;
  }
  $tables = [];
  while ($row = mysqli_fetch_assoc($result)) {
    array_push($tables, $row["table"]);
  }
  return $tables;
}

/*
 * add filters in request
 */
function __addFiltersInRequest($conn, $request){
  $parameters = getParameters($conn); //FK => Value
  $foreignParam = getForeignKeys($conn, "INFO_parameters_of_views"); // FK => Table
  $tablesOfRequest = __getTableFromRequest($conn, $request);

  dispDict("parameters", $parameters);
  dispDict("foreignParam", $foreignParam);
  dispDict("tablesOfRequest", $tablesOfRequest);
  
  $filter = "";
  foreach($tablesOfRequest as $table){
    $fk = array_search($table, $foreignParam);
    //print("table: " . $table . " fk: " . $fk . "</br>\n");
    if($fk && $parameters[$fk] != ""){
      $filter = $filter . $table . "." . $fk . " = \"" . $parameters[$fk] . "\" AND ";
    }
  }
  //print("filter: " . $filter .  "</br>\n");
  
  $filteredRequest = strstr($request, 'WHERE', true) . " WHERE " . $filter . substr(strstr($request, 'WHERE'), 5);

  return $filteredRequest;
}

  /**
   *
   */
function get_view($conn, $view_name, $request){

  $request = __addFiltersInRequest($conn, $request);

  //print($request . "\n");

  print("<button type=\"button\" class=\"collapsible\">$view_name</button>");
  
  print("
   <article class=\"content\">
      <table>
        <thead>");


  /*  on suppose, bien entendu, que la vue existe  */

  $result = mysqli_query($conn, $request);
    if (!$result) {
      echo 'Impossible d\'exécuter la requête : ' . $req;
      echo 'error '.mysqli_error();
      exit;
    }

    if (mysqli_num_rows($result) > 0) {
        print("<tr>");
	$fields = mysqli_fetch_fields($result);
	foreach($fields as $field){
	  print("<th>".$field->name."</th>");
	}
        print("</tr></thead>\n");
    }

    print("    <tbody>");
    

	//$result  = get_views($conn, $vue_name);
    
    while($ligne = mysqli_fetch_row ($result)){
   	print("<tr>");
   	foreach($ligne as $k=>$v){
	    print("<td>".$v."</td>");
	}
   	print("</tr>\n");
    }
    print("
        </tbody>
      </table>
	  </article>");

    mysqli_free_result($result);
	  }
	  ?>
