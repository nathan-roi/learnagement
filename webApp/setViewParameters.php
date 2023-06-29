<?php


if(isset($_POST['submit']))
{    
     require("connectDB.php");
     //$sessionId = $_POST['sessionId'];
     ($_POST['semestre'] == '') ? $semestre = '0' : $semestre = $_POST['semestre'];
     //$semestre = $_POST['semestre'];
     ($_POST['module'] == '') ? $module = 'NULL' : $module = $_POST['module'];
     //$module = $_POST['module'];
     ($_POST['enseignant'] == '') ? $enseignant = 'NULL' : $enseignant = $_POST['enseignant'];
     //$enseignant = $_POST['enseignant'];
     ($_POST['filiere'] == '') ? $filiere = 'NULL' : $filiere = $_POST['filiere'];
     //$filiere = $_POST['filiere'];


     $req = "TRUNCATE `INFO_vue_parameters`;";
     
     if (mysqli_query($conn, $req)) {
        echo "Parameters cleaned successfully!</br>";
     } else {
        echo "Error: " . $req . ":-" . mysqli_error($conn);
     }

     $req = "INSERT INTO `INFO_vue_parameters` (`id`, `sessionId`, `semestre`, `module`, `enseignant`, `filiere`) VALUES (NULL, '1', '$semestre', '$module', '$enseignant', '$filiere');";
     echo $req;

     if (mysqli_query($conn, $req)) {
        echo "New record has been added successfully!</br>";     
        require("disconnectDB.php");
        print("<meta http-equiv=\"refresh\" content=\"1;url=index.php\" />");
     } else {
        echo "Error: " . $req . ":-" . mysqli_error($conn);   
        require("disconnectDB.php");
     }
}
?>
