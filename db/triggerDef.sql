
DELIMITER $$

CREATE TRIGGER generate_seance_to_be_affectated AFTER INSERT ON data
FOR EACH ROW
BEGIN
INSERT IGNORE INTO INFO_seance_to_be_affected (`id_module`, `seance_type`, `numero_ordre`, `id_groupe`)
(SELECT
  `learnagement`.`INFO_module`.`id_module` AS `id_module`,
  `learnagement`.`INFO_module_sequencage`.`seanceType` AS `seance_type`,
  `learnagement`.`INFO_module_sequencage`.`numero_ordre` AS `numero_ordre`,
  `learnagement`.`INFO_groupe`.`id_groupe` AS `id_groupe`
  FROM `learnagement`.`INFO_module`
  JOIN `learnagement`.`INFO_module_as_promo` ON `learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_module_as_promo`.`id_module`
  JOIN `learnagement`.`INFO_promo` ON `learnagement`.`INFO_module_as_promo`.`id_promo` = `learnagement`.`INFO_promo`.`id_promo`
  JOIN `learnagement`.`INFO_groupe` ON `learnagement`.`INFO_promo`.`id_promo` = `learnagement`.`INFO_groupe`.`id_promo`
  JOIN `learnagement`.`INFO_module_sequencage` ON (`learnagement`.`INFO_module`.`id_module` = `learnagement`.`INFO_module_sequencage`.`id_module`) AND (`learnagement`.`INFO_groupe`.`groupe_type` = `learnagement`.`INFO_module_sequencage`.`groupe_type`))
