<?php
    require("requests.php");

    print("<button type=\"button\" class=\"collapsible\">$table_name</button>");

    print("
<article>
<div class=\"content\">
      <table>
        <thead>
    ");



    /* 
     * get the table primary K
     */


    $table = mysqli_query($conn, $primaryK_req);
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
	  if($row[3] != $primaryK && $row[3] != "modifiable"){ // do not display K and "modifiable" field
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
	  
    $result  =   mysqli_query($conn, $table_req);  
    
    if ($result === FALSE){
      echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysqli_error();
      exit; // inutile de poursuivre le traitement dans ce cas
    } 
    
   while($ligne = mysqli_fetch_row ($result)){
   	print("<tr>");
	print("<form action='' method='get' class='form-row'>");
   	foreach($ligne as $k=>$v){
	  // do not display modifiable field
	  if($fields_array[$k] == "modifiable"){
	    $modifiable = $v;
	    
	  // big text fields
	  }else if($fields_type[$k] == "text"){
	    print("<td><textarea name='$fields_array[$k]'>$v</textarea></td>");

	  // foreignK
	  }else if(in_array($fields_array[$k], $forefnK_fields_array)){
	      print("<td><select name='$fields_array[$k]'>");
	      foreach($forefnK_fields_values_dic[$fields_array[$k]] as $key => $value){
		if($key == $v){
	            print("<option selected=\"selected\" value=\"$key\">$value</option>");
		}else{
	            print("<option value=\"$key\">$value</option>");
		}
	      }
	      print("</select></td>");
	      
	  // primaryK
	  }else if($k == 0){
	    print("<input type='hidden' name='$fields_array[$k]' value=\"$v\">");
	    
	  // others
	  }else{
	    print("<td><input type='text' name='$fields_array[$k]' value=\"$v\"></td>");
	  }
	}
	if($modifiable){
	  print("<td><input type='submit' value='update'></td>");
	}else{
	  print("<td><input type='submit' value='update' disabled></td>");
	}
	print("</form>");
   	print("</tr>\n");
   }
	  print("<tr><form>");
	  foreach($fields_array as $k=>$v){
	  // do not display modifiable field
	  if($fields_array[$k] == "modifiable"){
	    $modifiable = 0;
	    
	  // big text fields
	  }else if($fields_type[$k] == "text"){
	    print("<td><textarea name='$fields_array[$k]'>$v</textarea></td>");

	  // foreignK
	  }else if(in_array($fields_array[$k], $forefnK_fields_array)){
	      print("<td><select name='$fields_array[$k]'>");
	      print("<option value=\"\">$fields_array[$k]</option>");
	      foreach($forefnK_fields_values_dic[$fields_array[$k]] as $key => $value){
		print("<option value=\"$key\">$value</option>");
	      }
	      print("</select></td>");
	      
	  // primaryK
	  }else if($k == 0){
	    print("<input type='hidden' name='$fields_array[$k]' value=\"$v\">");
	    
	  // others
	  }else{
	    print("<td><input type='text' name='$fields_array[$k]' value=\"$v\"></td>");
	  }
	}
	print("<td><input type='submit' value='insert'></td>");
	  print("</tr></form>\n");
	  print("    </tbody>");
	     mysqli_free_result($result); // libère l'espace mémoire occupé par le résultat
    
  print("</table>
</div>
</article>");
?>   
