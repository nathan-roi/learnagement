<?php
function viewSeance($conn, $input)
{
    preg_match('/([A-Za-z]+)(\d+)/', $input, $matches);
    if (count($matches) < 3) {
        return ["error" => "Format invalide"];
    }

    $type = $matches[1];
    $nombre = intval($matches[2]);

    $stmt = $conn->prepare("SELECT id_seance_type FROM LNM_seanceType WHERE type = ?");
    $stmt->bind_param("s", $type);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        $id_seance_type = $row['id_seance_type'];
    } else {
        return ["error" => "Type de séance non trouvé"];
    }

    $stmt = $conn->prepare("SELECT duree_h, id_module, nombre FROM MAQUETTE_module_sequencage WHERE id_seance_type = ? AND nombre = ?");
    $stmt->bind_param("ii", $id_seance_type, $nombre);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        $id_module = $row['id_module'];
        $duree_h = $row['duree_h'];
        $totalNumber = $row['nombre'];

        $stmt = $conn->prepare("SELECT nom, code_module FROM MAQUETTE_module WHERE id_module = ?");
        $stmt->bind_param("i", $id_module);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($moduleRow = $result->fetch_assoc()) {
            $moduleName = $moduleRow['nom'];
            $moduleCode = $moduleRow['code_module'];
        } else {
            $moduleName = "Inconnu";
            $moduleCode = "Inconnu";
        }

        return [
            "duree_h" => $duree_h,
            "typeCourse" => $type,
            "currentNumber" => $nombre,
            "moduleName" => $moduleName,
            "moduleCode" => $moduleCode,
            "totalNumber" => $totalNumber
        ];
    } else {
        return ["error" => "Aucune donnée trouvée"];
    }
}
