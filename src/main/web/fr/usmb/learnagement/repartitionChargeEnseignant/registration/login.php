<?php
session_start();
?>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="style.css" />
</head>
<body>
<?php
require_once('../config.php');
require('../connectDB.php');
//session_start();

if (isset($_POST['username'])){
	$username = stripslashes($_REQUEST['username']);
	//$username = mysql_real_escape_string($username, $conn);
	$username = mysqli_real_escape_string($conn, $username);
	$password = stripslashes($_REQUEST['password']);
	//$password = mysql_real_escape_string($password, $conn);
	$password = mysqli_real_escape_string($conn, $password);
    $query = "SELECT username FROM `INFO_enseignant` WHERE username='$username' and password='".hash('sha256', $password)."'";
	//$result = mysql_query($query, $conn) or die(mysql_error());
	$result = mysqli_query($conn,$query) or die(mysql_error());
	//$rows = mysql_num_rows($result);
	$rows = mysqli_num_rows($result);
	print($rows);
	if($rows==1){
	    $_SESSION['username'] = $username;
	    //header("Location: index.php");
	    print("<meta http-equiv=\"refresh\" content=\"0;url=../index.php\" />");
	}else{
		$message = "Le nom d'utilisateur ou le mot de passe est incorrect.";
	}
}
require('../disconnectDB.php');
?>
<form class="box" action="" method="post" name="login">
<h1 class="box-logo box-title">Gestion des services</h1>
<h1 class="box-title">Connexion</h1>
<input type="text" class="box-input" name="username" placeholder="Nom d'utilisateur">
<input type="password" class="box-input" name="password" placeholder="Mot de passe">
<input type="submit" value="Connexion " name="submit" class="box-button">
<p class="box-register">Permanant sans login ? <a href="register.php">S'inscrire</a></p>
<?php if (! empty($message)) { ?>
    <p class="errorMessage"><?php echo $message; ?></p>
<?php }?>
</form>
    <footer>
        Thanks to <a href="https://waytolearnx.com/">WayToLearnX.com</a>
    </footer>
</body>
</html>
