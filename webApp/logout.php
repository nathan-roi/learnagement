<?php
// On d�marre la session
session_start ();

session_regenerate_id(true);

// On d�truit les variables de notre session
session_unset ();

unset($_SESSION["loggedin"]);

// On d�truit notre session
session_destroy ();

// On redirige le visiteur vers la page d'accueil
header ('location: index.php');
?>
