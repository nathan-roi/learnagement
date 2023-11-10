<?php
    require("requests.php");

    print("<button type=\"button\" class=\"collapsible\">$table_name</button>");

    print("<div class=\"content\">
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
	  if($row[0] != $primaryK){
            print("<th>".$row[3]."</th>");
	    array_push($fields_array, $row[3]);
	    array_push($fields_type, $row[7]);
	    }
        }
	//$fields = substr($fields, 0, -1);
	$fields = implode(",", $fields_array);
        print("<th>Validation</th>");
        print("</tr></thead>\n");
    }
    require("requests.php");
    mysqli_free_result($table); // libère l'espace mémoire occupé par le résultat

    /*
     * get the table foreign Ks 
     */
    $forefnK_fields_array = [];
    $forefnKs = mysqli_query($conn, $foreignK_req);
    if (!$forefnKs) {
        echo 'Impossible d\'exécuter la requête : ' . $req;
        echo 'error '.mysqli_error();
        exit;
    }
    if (mysqli_num_rows($forefnKs) > 0) {
      while ($forefnK = mysqli_fetch_row($forefnKs)) {
	array_push($forefnK_fields_array, $forefnK[1]);
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
	  if($fields_type[$k] == "text"){
	    print("<td><textarea name='$fields_array[$k]'>$v</textarea></td>");
	  }else if(in_array($fields_array[$k], $forefnK_fields_array)){
	      print("<td><select name='$fields_array[$k]' value=\"$v\">");
	      print("<option value=\"$v\">$v</option>");
	      print("</select></td>");
	  }else{
	    print("<td><input type='text' name='$fields_array[$k]' value=\"$v\"></td>");
	  }
	}
	print("<td><input type='submit' value='valid'></td>");
	print("</form>");
   	print("</tr>\n");
   }
	  print("    </tbody>");
	     mysqli_free_result($result); // libère l'espace mémoire occupé par le résultat
    
  print("</table>
</div>");


 

?>   
