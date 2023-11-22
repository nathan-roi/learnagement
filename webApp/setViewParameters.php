<?php

if(isset($_POST['submit']))
{    
     require("connectDB.php");
     $sessionId = "\"".$_POST['sessionId']."\"";
 
     ($_POST['id_semestre'] == '') ? $semestre = 'NULL' : $semestre = $_POST['id_semestre'];
     //$semestre = $_POST['semestre'];
     ($_POST['code_module'] == '') ? $module = 'NULL' : $module = $_POST['code_module'];
     //$module = $_POST['module'];
     ($_POST['fullname'] == '') ? $enseignant = 'NULL' : $enseignant = $_POST['fullname'];
     //$enseignant = $_POST['enseignant'];
     ($_POST['nom_filiere'] == '') ? $filiere = 'NULL' : $filiere = "\"".$_POST['nom_filiere']."\"";
     //$filiere = $_POST['filiere'];

     $req = "TRUNCATE `INFO_parameters_of_views`;";
     
     if (mysqli_query($conn, $req)) {
       //echo "Parameters cleaned successfully!</br>";


	$req = "INSERT INTO `INFO_parameters_of_views` (`id_parameters_of_views`, `sessionId`, `id_semestre`, `code_module`, `fullname`, `nom_filiere`) VALUES (NULL," . $sessionId . "," . $semestre . "," . $module . "," . $enseignant . ", " . $filiere . ");";

	//print($req);
	if (mysqli_query($conn, $req)) {
	  /*echo "New record has been added successfully!</br>";     
	  require("disconnectDB.php");
	  print("<meta http-equiv=\"refresh\" content=\"1;url=index.php\" />");*/
	  header('location: index.php');
	} else {
	  echo "Error: " . $req . ":-" . mysqli_error($conn);   
	  require("disconnectDB.php");
	}
     } else {
        echo "Error: " . $req . ":-" . mysqli_error($conn);
     }
}
?>
