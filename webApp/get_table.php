<?php
    include("requests.php");

    print("<button type=\"button\" class=\"collapsible\">$table_name</button>");

    print("<div class=\"content\">
      <table>
        <thead>
    ");


    /* 
     * get the table fields
     */

    $table = mysqli_query($conn, $columns_table_req);
    if (!$table) {
        echo 'Impossible d\'exécuter la requête : ' . $req;
        echo 'error '.mysqli_error();
        exit;
    }

    /*
     * display fields
     */
    if (mysqli_num_rows($table) > 0) {
        print("<tr>");
        while ($row = mysqli_fetch_row($table)) {
            print("<th>".$row[0]."</th>");
        }
        print("<th>Validation</th>");
        print("</tr></thead>\n");
    }

    mysqli_free_result($table); // libère l'espace mémoire occupé par le résultat

    /*
     * get the table primary K 
     */


    /*
     * get the table foreign Ks 
     */
/*$forefnKs = mysqli_query($conn, $foreignK_req);
    if (!$result) {
        echo 'Impossible d\'exécuter la requête : ' . $req;
        echo 'error '.mysqli_error();
        exit;
*/}


    /* 
     * get the table data
     */
    print("    <tbody>");
    // envoi de la requête au serveur qui retourne un résultat    

    $result  =   mysqli_query($conn, $vue_req);  
    
    if ($result === FALSE){
      echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysqli_error();
      exit; // inutile de poursuivre le traitement dans ce cas
    } 
    
   while($ligne = mysqli_fetch_row ($result)){
   	print("<tr>");
	print("<form action='' method='get' class='form-row'>");
   	foreach($ligne as $k=>$v){
	    //print("<td>".$v."</td>");
	    print("<td><input type='text' name='$k' value='$v'></td>");
	}
	print("<td><input type='submit' value='valid'></td>");
	print("</form>");
   	print("</tr>\n");
   }
print("
    </tbody>
  </table>
</div>");

   mysqli_free_result($result); // libère l'espace mémoire occupé par le résultat 

 //  }else{
//	print("Vue not found!");
//   }

?>   
