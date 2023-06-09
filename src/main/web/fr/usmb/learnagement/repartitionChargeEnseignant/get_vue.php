<?php


print("<button type=\"button\" class=\"collapsible\">$vue_name</button>");

print("<div class=\"content\">
  <table>
    <thead>");


/*  on suppose, bien entendu, que la vue existe  */

$req = "SHOW COLUMNS FROM $vue_name";
$result = mysqli_query($conn, $req);
if (!$result) {
  echo 'Impossible d\'exécuter la requête : ' . $req;
  echo 'error '.mysqli_error();
  exit;
}

if (mysqli_num_rows($result) > 0) {
print("<tr>");
   while ($row = mysqli_fetch_row($result)) {
      print("<th>".$row[0]."</th>");
   }
   print("</tr></thead>\n");
}

    mysqli_free_result($result); // libère l'espace mémoire occupé par le résultat

    print("    <tbody>");
    // envoi de la requête au serveur qui retourne un résultat    
    $req = " SELECT * FROM  $vue_name WHERE 1 ";
    $result  =   mysqli_query($conn, $req);  
    
    if ($result === FALSE){
      echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysqli_error();
      exit; // inutile de poursuivre le traitement dans ce cas
    } 
    
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
</div>");

   mysqli_free_result($result); // libère l'espace mémoire occupé par le résultat 

 //  }else{
//	print("Vue not found!");
//   }

?>   
