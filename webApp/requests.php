<?php
  // get login informations
  $login_req = "SELECT id_enseignant, prenom, nom, password FROM INFO_enseignant WHERE mail = \"$userlogin\"";



// get all views
$vues_req = "SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = \"VIEW\" AND TABLE_NAME LIKE \"VUE_%\"";

// get all tables
$tables_req = "SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = \"BASE TABLE\" AND TABLE_NAME LIKE \"INFO_%\"";

$modifiable_tables_req = "SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME IN ('modifiable') AND TABLE_SCHEMA='learnagement'";


// get view column names
$columns_vue_req = "SHOW COLUMNS FROM $vue_name";

// get view column names
//$columns_table_req = "SHOW COLUMNS FROM $table_name";
$columns_table_req = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'learnagement' AND table_name = '$table_name' ORDER BY `COLUMNS`.`ORDINAL_POSITION`";

// get view content
$vue_req = " SELECT * FROM  $vue_name WHERE 1 ";


// get primary Key
$primaryK_req = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'learnagement' AND COLUMN_KEY = 'PRI' AND table_name = \"$table_name\"";

// get explicit secondary Key
$secondaryK_req = "SHOW INDEXES FROM $table_name WHERE `Key_name`=\"SECONDARY\"";

// get foreign keys of a table
$foreignK_req = "SELECT TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_SCHEMA = \"$mysql_db\" AND TABLE_NAME = \"$table_name\"";

// get secondary K fields
$secondaryk_fields_req = "SELECT group_concat(column_name  separator ', ') FROM information_schema.statistics WHERE table_schema = \"$mysql_db\" AND table_name= \"$reference_table_name\" AND (INDEX_NAME = \"PRIMARY\" OR INDEX_NAME = \"SECONDARY\")";

// get secondary K values
$secondaryk_values_req = "SELECT $primaryk_and_secondaryK FROM $reference_table_name ORDER BY 1"; 
?>
