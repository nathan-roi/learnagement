<?php
    require_once("config.php");

/**
 *
 */
function get_views_old($conn, $vue_name){
  $vue_req = " SELECT * FROM  $vue_name WHERE 1 ";

  $result  =   mysqli_query($conn, $vue_req);

  if ($result === FALSE){
      echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysqli_error();
      exit; // inutile de poursuivre le traitement dans ce cas
    }

  return $result;
}

function get_views($conn){
  $views_req = "SELECT `name`, `request` FROM `INFO_view` WHERE 1 ORDER BY `sortIndex`";

  $views = mysqli_query($conn, $views_req);

if (!$views) {
  echo 'Impossible d\'exécuter la requête : ' . $req;
  echo 'error '.mysqli_error($conn);
  exit;
 }

 return $views;
}
?>
