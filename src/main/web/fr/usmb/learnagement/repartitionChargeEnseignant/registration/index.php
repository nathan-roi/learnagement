<?php
	// Initialiser la session
	session_start();
	// Vérifiez si l'utilisateur est connecté, sinon redirigez-le vers la page de connexion
	if(!isset($_SESSION["username"])){
		header("Location: registration/login.php");
		exit(); 
	}
?>
<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" href="style.css" />
	</head>
	<body>
		<div class="sucess">
		<h1>Bienvenue <?php echo $_SESSION['username']; ?>!</h1>
		<p>C'est votre tableau de bord.</p>
		<a href="affiche_modules.php">Modules</a></br>
		<a href="affiche_resume.php">Resumé</a></br>
		<a href="affiche_responsabilite.php">Responsables</a></br>
		<a href="profil.php">Profil</a></br>
		<a href="logout.php">Déconnexion</a>
		</div>
	</body>
</html>
