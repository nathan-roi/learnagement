<?php

require_once("config.php");
include("script_affiche_list_enseignants.php");

// récupération des paramètres du script (ici la méthode GET a été utilisée)
if (  array_key_exists("module_id", $_GET)) {

// on crée une variable portant le nom du paramètre
   $module_id = $_GET["module_id"];

   $req = " SELECT * FROM  `IAI_module` WHERE `IAI_module`.`id` = $module_id  ";

/**===========================   inclusion des informations de connexion BDD ====*/
require_once("config.php");



/*  on suppose, bien entendu, que la table existe  */


// envoi de la requête au serveur qui retourne un résultat    
    $resultat  =   mysql_query($req);  
    
    if ($resultat === FALSE){
      echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysql_error();
      exit; // inutile de poursuivre le traitement dans ce cas
    } 
    

   $ligne = mysql_fetch_row ($resultat);

   $id_module = $ligne[0];
   $code_module = $ligne[1];
   $nom_module = $ligne[2];
   $semestre_module = $ligne[3];
   $filiere_module = $ligne[4];
   $id_resp_module = $ligne[5];
   $comment = $ligne[6];


   mysql_free_result($resultat); // libère l'espace mémoire occupé par le résultat 

   echo "Module: ".$code_module." - ".$nom_module." (".$filiere_module.") </br>-";

   // affiche enseignant
   if(!is_null($id_resp_module)){
	$id_enseignant = $id_resp_module;
	include("script_affiche_enseignant.php");
  }

  echo "- ";

  // get list enseignants responsable
if (isset($_SESSION['login']) && isset($_SESSION['pwd'])) {
  echo '<form method="get" action="script_modify_resp.php" name="modify_resp">
      <input type="hidden" name="module_id" value="'.$module_id.'">';

  //include("script_affiche_list_enseignants.php");
  affiche_list_enseignants();

  echo' <input value="modifier" name="valider" type="submit">
         </form>';
}


   $req = " SELECT * FROM  `IAI_CMTDTP` WHERE `IAI_CMTDTP`.`module_id` = $module_id  ORDER BY 2, 3, 5";

   $resultat  =   mysql_query($req);  
    
   if ($resultat === FALSE){
      echo "la requ&ecirc;te a &eacute;chou&eacute; : ".mysql_error();
      exit; // inutile de poursuivre le traitement dans ce cas
   } 

   echo "<table>";

   echo "<tr>\n";
   echo "<th>Lieu</th> <th>Type</th> <th>Heure</th> <th>Intervenant</th>\n";
   echo "</tr>\n";
   // affichage du contenu de la table sous forme d'une liste 
      
   while($ligne = mysql_fetch_row ($resultat)) {  
    //  à chaque itération de cette boucle 
    //  la variable $ligne récupère un tableau dont les éléments sont les champs
    //  de l'enregistrement. (cf doc en ligne)

    $id_CMTDTP = $ligne[0];
    $lieu_CMTDTP = $ligne[1];
    $type_CMTDTP = $ligne[2];
    $heure_CMTDTP = $ligne[3];
    $id_intervenant_CMTDTP = $ligne[4];
    
        echo ("\t<tr>");   
         //   on ajoute une ligne à la liste pour chaque enregistrement

	echo "\t\t<td>".$lieu_CMTDTP."</td><td>".$type_CMTDTP."</td><td>".$heure_CMTDTP."</td><td>";

	$id_enseignant = $id_intervenant_CMTDTP;
	include("script_affiche_enseignant.php");

	echo "</td><td>";
if (isset($_SESSION['login']) && isset($_SESSION['pwd'])) {
	// get list enseignants intervenant
	echo "<form method='get' action='script_modify_intervenant.php' name='modify_resp".$id_CMTDTP."'>\n";
      	echo "<input type='hidden' name='CMTDTP_id' value='".$id_CMTDTP."'>\n";
        echo "<input type='hidden' name='module_id' value='".$module_id."'>\n";

  	//include("script_affiche_list_enseignants.php");
	affiche_list_enseignants();

  	echo  "<input value='modifier' name='valider' type='submit'>\n</form>\n";
}
        echo ("\t</tr> \n");      //  fin d'une ligne
   } // fin while

   echo ( " </table> \n");      //  fin du tableau

   mysql_free_result($resultat); // libère l'espace mémoire occupé par le résultat 
   mysql_close ($lien); // fermeture de la connexion à la base de données

  // display module comment
  echo("commentaires :<br/>");
echo("<pre>");
  echo($comment);
echo("</pre>");
 }else{
echo "No module selected !";
}
?>   
