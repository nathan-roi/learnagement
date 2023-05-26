# learnagement
Learning management

## BD structure

La base de données s'organise autour de 3 objectifs: la gestion du planing prévisionel des enseignants, la cohérence entre le MCCC le prévisionel et la planification réelle et la gestion des abscences des étudiants.

### Organisation des modules

* INFO_module
* INFO_promo
* INFO_module_as_promo

La table module contient la maquette des formations, c'est à dire les modules et leur découpe en CM, TD, TP et TPD (TP en groupe de TD).
Les modules sont associés à une ou plusieurs promotions, au travers de la table de liaison "module_as_promo".

### prévisionel enseignants

Tables:

* INFO_CMTDTP
* INFO_module

Les CMTDTP correspondent à la découpe prévisionnelle des modules entre les enseignants.
Chaque élément de découpe, tuple, est associé à un module.
Un élément de découpe est un nombre d'heures de CM, TP ou TPD.

### MCCC, prévisionel et panning

Tales :

* INFO_module
* INFO_CMTDTP
* INFO_seance

Les modules sont associés à une ou plusieurs promotions, au travers de la table de liaison "module_as_promo".
Les CMTDTP correspondent à la découpe prévisionnelle des enseignement entre les enseignants.
Les séances quant à elles, sont celles réellement planifiées et sont atachés à un module et un groupe étudiant.

### Abscences des étudiants

Tables :

* INFO_etudiant
* INFO_promo
* INFO_groupe_etudiant
* INFO_etudiant_as_groupe_etudiant
* INFO_module
* INFO_module_as_promo
* INFO_seance

Un étudiant est associé à une promotion qui différencie année et filière, l'étudiant est également associé à un groupe élémentaire qui ne corespond pas à un groupe de CM, TD ou TP. Ce groupe élémentaire permet de gérer les groupes d'étudiants de manière plus souple que les groupes de CM, TD et TP. Ainsi, un groupe etudiant (CM, TD, TP ou autre) est composé de plusieurs groupes élémentaires.


## Contraintes

Toutes les tables de données (hors table de liaisons) doivent avoir une clé primaire numérique composée d'un seul attribut et une clé secondaire composé d'un ensemble d'attributs humainement compréhensible.
Cet ensemble doit être déclaré comme unique avec pour nom d'indexe "SECONDARY".

## ToDo

* Gérer les dépendances
  	* Gérer les dépendances CM, TD et TP intra et inter module
	* Gérer les dépendances entre modules (le dernier CM, TD ou TP de l'un doit être avant le 1er de l'autre)
	* Attention aux incohérences, pour 2 modules donnés, soit CM, TD, TP, soit entre modules