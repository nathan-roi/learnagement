<?php
//echo "<button type=\"button\" class=\"collapsible\">$vue_name</button>";
echo "<button type=\"button\" >$vue_name</button>";
//echo "<div class=\"content\">
echo "<div>
    <table>
        <thead>";

// Obtenir les colonnes de la vue
$req = "SHOW COLUMNS FROM $vue_name";
$result = mysqli_query($conn, $req);

if (!$result) {
    echo 'Impossible d\'exécuter la requête : ' . $req;
    echo 'error ' . mysqli_error($conn);
    exit;
}
//Réalisation d'un tableau
if (mysqli_num_rows($result) > 0) {
    echo "<tr>";
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<th>" . $row['Field'] . "</th>\n";
    }
    echo "</tr></thead>";
}

mysqli_free_result($result);

echo "<tbody>";
// Exécuter la requête pour récupérer les données de la vue
$req = "SELECT * FROM $view[0]";
$result = mysqli_query($conn, $req);

if ($result === FALSE) {
    echo "La requête a échoué : " . mysqli_error($conn);
    exit;
}

while ($row = mysqli_fetch_assoc($result)) {
    echo "<tr>";
    foreach ($row as $value) {
        echo "<td>" . $value . "</td>\n";
    }
    echo "</tr>";
}


echo "</tbody>
    </table>
</div>";
?>
