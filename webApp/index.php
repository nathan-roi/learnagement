<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
UserDir Test Page
</div>

 <?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "learnagement";
$port = 43306;

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname, $port);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully1";
?>

</body>
</html>
