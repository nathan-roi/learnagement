
DELIMITER $$

CREATE TRIGGER generate_seance_to_be_affectated AFTER INSERT ON data
FOR EACH ROW
BEGIN
INSERT IGNORE INTO INFO_seance_to_be_affected (`id_module_sequence`, `id_groupe`)
(SELECT
  `learnagement`.`INFO_module_sequence`.`id_module_sequence` AS `id_module_sequence`,
  `learnagement`.`INFO_groupe`.`id_groupe` AS `id_groupe`
  FROM `learnagement`.`INFO_module`

  JOIN INFO_module_as_learning_unit ON INFO_module_as_learning_unit.id_module = INFO_module.id_module
  JOIN INFO_learning_unit ON INFO_learning_unit.id_learning_unit = INFO_module_as_learning_unit.id_learning_unit
  JOIN INFO_promo ON INFO_learning_unit.id_promo = INFO_promo.id_promo
  
  JOIN `learnagement`.`INFO_groupe` ON `learnagement`.`INFO_promo`.`id_promo` = `learnagement`.`INFO_groupe`.`id_promo`
  JOIN `learnagement`.`INFO_module_sequencage` ON (`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_module_sequencage`.`id_module`) AND (`learnagement`.`INFO_groupe`.`groupe_type` = `learnagement`.`INFO_module_sequencage`.`groupe_type`))





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
  JOIN `learnagement`.`INFO_module_sequencage` ON (`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_module_sequencage`.`id_module`) AND (`learnagement`.`INFO_groupe`.`groupe_type` = `learnagement`.`INFO_module_sequencage`.`groupe_type`)
)
INSERT IGNORE INTO INFO_type_seance_to_be_affected_as_enseignant (id_type_seance_to_be_affected)
(
SELECT id_type_seance_to_be_affected
FROM INFO_type_seance_to_be_affected
)
