<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Learnagement</title>
    <link href="inc/css/style.css" rel="stylesheet" type="text/css">
  </head>
  <body class="loggedin">
    <header>
      <h1>Learnagement</h1>
    </header>
    <nav class="navtop">
      <div>
        <a href="profile.php"><i class="fas fa-user-circle"></i>Profile</a>
        <a href="login.php"><i class="fas fa-sign-in-alt"></i>Login</a>
        <a href="logout.php"><i class="fas fa-sign-out-alt"></i>Logout</a>
      </div>
    </nav>
    <aside>
      <?php include("filter.php"); ?> 
    </aside>
    <main>
      <?php include("view.php"); ?> 
    </main>
    <footer>
    footer
    </footer>
  </body>
</html>
