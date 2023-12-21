<?php
require_once("config.php");
require_once("functions.php");
   
$sessionId = session_id();


include("connectDB.php");

// get parameters according to the session
$param_req = "SELECT * FROM `INFO_parameters_of_views` WHERE `sessionId` =  \"$sessionId\"";

/*
 * get parameters fields
 */
$result = mysqli_query($conn, $param_req);

if (!$result) {
  echo 'Impossible d\'exécuter la requête : ' . $req;
  echo 'error ' . mysqli_error($conn);
  exit;
 }
$parameter_fields = [];
$fields = mysqli_fetch_fields($result); 

foreach($fields as $field){
  if($field->name != "id_parameters_of_views" && $field->name != "sessionId" && $field->name != "userId"){
    array_push($parameter_fields, $field->name);
  }
}

/*
 * get parameters: filters values
 */


$parameter_values=[];
if (mysqli_num_rows($result) > 0) {
  $parameter_values = mysqli_fetch_assoc($result);
 }

/*
 * Get all foreign keys with their secondary keys values
 */
$forefnK_fields_values_dic = [];
$foreignKs = getForeignKeys($conn,  "INFO_parameters_of_views");
foreach($foreignKs as $foreignK => $foreignTable){
  $psK_values_dic = getPrimarySecondaryKeyValues($conn, $foreignTable);
  $forefnK_fields_values_dic += [$foreignK => $psK_values_dic];
}


/*
 * Diplay form
 */
print("
        <div class=\"paramview\">
            <form action=\"setViewParameters.php\" method=\"post\">
    ");

    foreach($parameter_fields as $parameter_field){
          
      print("
        <div class=\"form-group\">
          <div class=\"dropdown\">
            <label for=\"$parameter_field-select\">$parameter_field :</label>
            <select name=\"$parameter_field\" id=\"$parameter_field-select\">
	    <option value=\"\"></option>
     ");
	    //<option value='$parameter_values[$parameter_field]'>$parameter_values[$parameter_field]</option>
	      foreach($forefnK_fields_values_dic[$parameter_field] as $key => $value){
		if($key == $parameter_values[$parameter_field]){
	            print("<option selected=\"selected\" value=\"$key\">$value</option>");
		}else{
	            print("<option value=\"$key\">$value</option>");
		}
	      }
     
      print("
            </select>
          </div>
        </div>
	    ");
    }
    print("
      <button type=\"submit\" name=\"submit\" value=\"Submit\" class=\"btn-validate\">Valider</button>
    </form>
  </div>
    ");	
?>
