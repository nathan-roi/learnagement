<?php
/*******************************************************************************
   Repérage du répertoire de base sur le serveur http et du répertoire 'include'
  qu'il contient.
  Les lignes qui suivent utilisent les expressions régulières (très pratiques 
  pour effectuer des recherches, extractions, modifications dans des chaînes de
  caractères). Ici on recherche dans le chemin complet du script le chemin  
  complet du dossier 'public_html' vu par le serveur. A partir de ce chemin,
  quelque soit le sous-répertoire dans lequel ce trouve ce script, le chemin
  exact du répertoire 'include' est reconstruit.
******************************************************************************/
  //$base_dir = ereg_replace("(/public_html).*", "\\1",$_SERVER['SCRIPT_FILENAME']);
  //$base_dir = preg_replace("/public_html#", "\\1",$_SERVER['SCRIPT_FILENAME']);
  $base_dir = "/home/flver/public_html";
  //print($base_dir);

// construction du chemin pour le répertoire include
  $inc_dir = $base_dir."/include/";

// inclusion des informations de connexion à la base de données MySQL
  include($inc_dir."mysql_inc.php");

// Session timeout in second
  $session_timeout = 1440;
?>
