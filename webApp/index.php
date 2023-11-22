<?php
  session_start();
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Learnagement</title>
    <link href="inc/css/style.css" rel="stylesheet" type="text/css">
  </head>
  <body class="loggedin" onload="setMain(getCookie('mainPage')); setCollapsible();">
    <header>
      <h1>Learnagement</h1>
    </header>
    <nav class="navtop">
      <div>
        <a href="#" onclick="setMain('view.php');">View</a>
   <?php
    if(isset($_SESSION['loggedin'])){
      print("<a href=\"#\" onclick=\"setMain('modif.php');\">Manage</a>\n");
      print("<a href=\"profile.php\"><i class=\"fas fa-user-circle\"></i>" . $_SESSION['userFirstname'] . " " . $_SESSION['userLastname'] . "</a>\n");
      print("<a href=\"logout.php\"><i class=\"fas fa-sign-out-alt\"></i>Logout</a>\n");
   }else{
      // set view as main page
      print("<script>
	    document.cookie = 'mainPage='.concat('', 'view.php').concat('','; SameSite=Strict');
	    </script>");
      print("<a href=\"login.php\"><i class=\"fas fa-sign-in-alt\"></i>Login</a>\n");
       }
   ?>
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

    <script type="text/javascript">

    function getCookie(name) {
      const value = `; ${document.cookie}`;
      const parts = value.split(`; ${name}=`);
      if (parts.length === 2) return parts.pop().split(';').shift();
    }


   function setCollapsible(){
   var coll = document.getElementsByClassName("collapsible");
   var i;
   
   for (i = 0; i < coll.length; i++) {
     coll[i].addEventListener("click", function() {
	 this.classList.toggle("active");
	 var content = this.nextElementSibling;
	 if (content.style.display === "block") {
	   content.style.display = "none";
	 } else {
	   content.style.display = "block";
	 }
       });
   }
 }

   function setMain(fileName){
    
   
   var xhr = typeof XMLHttpRequest != 'undefined' ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
   xhr.open('get', fileName, true);
   xhr.onreadystatechange = function() {
     if (xhr.readyState == 4 && xhr.status == 200) { 
       document.getElementsByTagName('main')[0].innerHTML = xhr.responseText;
       setCollapsible();
     } 
   }
   xhr.send();
   document.cookie = 'mainPage='.concat('', fileName).concat('',"; SameSite=Strict");
 }
</script>
  </body>
    
</html>
