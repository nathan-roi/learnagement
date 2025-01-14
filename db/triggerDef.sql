
DELIMITER $$

CREATE TRIGGER generate_seance_to_be_affectated AFTER INSERT ON data
FOR EACH ROW
BEGIN

INSERT IGNORE INTO `INFO_module_sequence`  (`id_module_sequencage`,`numero_ordre`,`commentaire`)
SELECT `id_module_sequencage`, orders, null
FROM `INFO_module_sequencage`, 
(VALUES ROW (1), ROW(2), ROW(3), ROW (4), ROW(5), ROW(6), ROW (7), ROW(8), ROW(9), 
 ROW (10), ROW (11), ROW(12), ROW(13), ROW (14), ROW(15), ROW(16), ROW (17), ROW(18), ROW(19),
 ROW (20), ROW (21), ROW(22), ROW(23), ROW (24), ROW(25), ROW(26), ROW (27), ROW(28), ROW(29),
 ROW (30), ROW (31), ROW(32), ROW(33), ROW (34), ROW(35), ROW(36), ROW (37), ROW(38), ROW(39)  ) sub(orders)
WHERE orders <= nombre

INSERT IGNORE INTO INFO_seance_to_be_affected (`id_module_sequence`, `id_groupe`)
SELECT
  `learnagement`.`INFO_module_sequence`.`id_module_sequence` AS `id_module_sequence`,
  `learnagement`.`INFO_groupe`.`id_groupe` AS `id_groupe`
  
  FROM `INFO_module`

  JOIN INFO_module_as_learning_unit ON INFO_module_as_learning_unit.id_module = INFO_module.id_module
  JOIN INFO_learning_unit ON INFO_learning_unit.id_learning_unit = INFO_module_as_learning_unit.id_learning_unit
  JOIN INFO_promo ON INFO_learning_unit.id_promo = INFO_promo.id_promo
  
  JOIN `INFO_groupe` ON `INFO_promo`.`id_promo` = `INFO_groupe`.`id_promo`
  
  JOIN `INFO_module_sequencage` ON (`INFO_module`.`id_module` = `INFO_module_sequencage`.`id_module`) AND (`INFO_groupe`.`id_groupe_type` = `INFO_module_sequencage`.`id_groupe_type`)
  JOIN INFO_module_sequence ON INFO_module_sequence.id_module_sequencage = INFO_module_sequencage.id_module_sequencage


// look for the module responsible for id_responsable
INSERT IGNORE INTO INFO_seance_to_be_affected_as_enseignant (id_seance_to_be_affected, id_responsable)

SELECT id_seance_to_be_affected
FROM INFO_seance_to_be_affected




CREATE TRIGGER generate_type_seance_to_be_affectated AFTER INSERT ON data
FOR EACH ROW
BEGIN
INSERT IGNORE INTO INFO_type_seance_to_be_affected (`id_module_sequencage`, `id_groupe`)
(
SELECT
  `learnagement`.`INFO_module_sequencage`.`id_module_sequencage` AS `id_module_sequencage`,
  `learnagement`.`INFO_groupe`.`id_groupe` AS `id_groupe`
  
  FROM `learnagement`.`INFO_module`

  JOIN INFO_module_as_learning_unit ON INFO_module_as_learning_unit.id_module = INFO_module.id_module
  JOIN INFO_learning_unit ON INFO_learning_unit.id_learning_unit = INFO_module_as_learning_unit.id_learning_unit
  JOIN INFO_promo ON INFO_learning_unit.id_promo = INFO_promo.id_promo
  
  JOIN `learnagement`.`INFO_groupe` ON `learnagement`.`INFO_promo`.`id_promo` = `learnagement`.`INFO_groupe`.`id_promo`
  JOIN `learnagement`.`INFO_module_sequencage` ON (`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_module_sequencage`.`id_module`) AND (`learnagement`.`INFO_groupe`.`id_groupe_type` = `learnagement`.`INFO_module_sequencage`.`id_groupe_type`)
)

// look for the module responsible for id_responsable
INSERT IGNORE INTO INFO_type_seance_to_be_affected_as_enseignant (id_type_seance_to_be_affected, id_responsable)
(
SELECT id_type_seance_to_be_affected
FROM INFO_type_seance_to_be_affected
)


REPLACE INTO INFO_seance_to_be_affected_as_enseignant (id_seance_to_be_affected, `id_enseignant`, `id_responsable`)
SELECT INFO_seance_to_be_affected.id_seance_to_be_affected, INFO_type_seance_to_be_affected_as_enseignant.id_enseignant, 18
FROM `INFO_type_seance_to_be_affected_as_enseignant` 
JOIN INFO_type_seance_to_be_affected ON INFO_type_seance_to_be_affected.id_type_seance_to_be_affected = INFO_type_seance_to_be_affected_as_enseignant.id_type_seance_to_be_affected
JOIN INFO_module_sequencage ON INFO_module_sequencage.id_module_sequencage = INFO_type_seance_to_be_affected.id_module_sequencage
JOIN INFO_module_sequence ON INFO_module_sequence.id_module_sequencage = INFO_module_sequencage.id_module_sequencage
JOIN INFO_seance_to_be_affected ON INFO_seance_to_be_affected.id_module_sequence = INFO_module_sequence.id_module_sequence AND INFO_seance_to_be_affected.id_groupe = INFO_type_seance_to_be_affected.id_groupe
WHERE INFO_module_sequencage.id_module =  and INFO_type_seance_to_be_affected_as_enseignant.id_enseignant is not null;
