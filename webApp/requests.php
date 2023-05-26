
$vues_req = "SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = \"VIEW\" AND TABLE_NAME LIKE \"INFO_vue_%\";";

$tables_req = "SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_TYPE = \"BASE TABLE\" AND TABLE_NAME LIKE \"INFO_%\";";

$secondaryK_req = "SHOW INDEXES FROM `INFO_enseignant` WHERE `Key_name`=\"SECONDARY\";";

$foreignK_req = 