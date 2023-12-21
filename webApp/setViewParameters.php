<?php
session_start();

if(isset($_POST['submit']))
{    
  require("connectDB.php");
  $sessionId = session_id();
  if(isset($_SESSION['userId'])){
    $userId = "\"".$_SESSION['userId']."\"";
  }else{
    $userId = "NULL";
  }
   
  ($_POST['id_semestre'] == '') ? $semestre = 'NULL' : $semestre = $_POST['id_semestre'];
  ($_POST['id_module'] == '') ? $module = 'NULL' : $module = $_POST['id_module'];
  ($_POST['id_discipline'] == '') ? $discipline = 'NULL' : $discipline = $_POST['id_discipline'];
  ($_POST['fullname'] == '') ? $enseignant = 'NULL' : $enseignant = $_POST['fullname'];
  ($_POST['nom_filiere'] == '') ? $filiere = 'NULL' : $filiere = "\"".$_POST['nom_filiere']."\"";

  $req = "INSERT INTO `INFO_parameters_of_views` (`id_parameters_of_views`, `userId`, `sessionId`, `id_semestre`, `id_module`, `id_discipline`, `fullname`, `nom_filiere`) VALUES (NULL," .$userId . ",\"" . $sessionId . "\"," . $semestre . "," . $module . "," . $discipline . "," . $enseignant . ", " . $filiere . ") ON DUPLICATE KEY UPDATE userId=" . $userId  . ",id_semestre=" . $semestre . ",id_module=" . $module . ",id_discipline=" . $discipline . ",fullname=" . $enseignant . ", nom_filiere=" . $filiere;

  //print($req);
  if (mysqli_query($conn, $req)) {
    header('location: index.php');
  } else {
    echo "Error: " . $req . ":-" . mysqli_error($conn);   
    require("disconnectDB.php");
  }
}
?>
