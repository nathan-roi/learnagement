<?php

    require_once("config.php");
    require_once("functions.php");
    if (isset($_SESSION['start']) && (time() - $_SESSION['start'] > $session_timeout)) {
       session_unset(); 
       session_destroy(); 
       echo "you were disconnected due to a session timeout"; 
    }
    $_SESSION['start'] = time();


    /*
     * Check user connection
     */
    if(!isset($_SESSION["loggedin"])){
        /*header("Location: registration/login.php");
        exit();*/
        $username="anonymous";
	$sessionId = "0";
    }else{
      //$username=$_SESSION["username"];
        $sessionId = session_id();
    }

    include("connectDB.php");
    require("requests.php");

    /*
     * get parameters fields
     */
    $result = mysqli_query($conn, $param_fields_req);

    if (!$result) {
      echo 'Impossible d\'exécuter la requête : ' . $req;
      echo 'error ' . mysqli_error($conn);
      exit;
    }
    $parameter_fields = [];
    if (mysqli_num_rows($result) > 0) {
      while ($row = mysqli_fetch_assoc($result)) {
	if($row['Field'] != "id_parameters_of_views" && $row['Field'] != "sessionId"){
          array_push($parameter_fields, $row['Field']);
	}
      }
    }else{
      print("No filter parameters found!");
    }


    /*
     * get parameters: filters values
     */
    $result = mysqli_query($conn, $param_req);

    if (!$result) {
      echo 'Impossible d\'exécuter la requête : ' . $req;
      echo 'error ' . mysqli_error($conn);
      exit;
    }
    $parameter_values=[];
    if (mysqli_num_rows($result) > 0) {
        $parameter_values = mysqli_fetch_assoc($result);
    }

//$forefnK_fields_values_dic = getSecondaryKs("INFO_parameters_of_views");
/*
     * get the table foreign Ks 
     */

$table_name = "INFO_parameters_of_views";
  require("requests.php");
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
 * Diplay form
 */
 print("
        <div class=\"paramview\">
            <form action=\"setViewParameters.php\" method=\"post\">
                <input type=\"hidden\" id=\"sessionId\" name=\"sessionId\" value=\"$sessionId\" />
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
