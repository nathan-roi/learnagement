<?php
function get_view($conn, $view_name, $request){

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
