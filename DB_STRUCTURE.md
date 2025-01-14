table de base

INFO_discipline : liste des disciplines
INFO_enseignant : liste des enseignants
INFO_etat_module : etat possible d'un module (production, projet...)
INFO_filiere : liste des filières
INFO_groupe : groupes d'étudiants
INFO_groupe_type : type de groupe
INFO_learning_unit : unité d'enseignement (UE) qui regrouperont des modules
INFO_module : enseble des modules
INFO_module_sequencage : decomposition des modules en groupe de CM, TD, TP...
INFO_module_sequence : decomposition des module en sequence de CM, TD, TP... Populé automatiquement à partir de INFO_module_sequencage. (A REFACTORISER POUR METTRE LA DEPENDANCE A INFO_module_sequencage)
INFO_parameters_of_views : enregistrement des sessions utilisateurs et gestion automatique des paramètres d'accès au données pour les IHM
INFO_promo : définition des promo selon : filières, status, lieu, année...
INFO_seanceType : définition des type de séances : CM, TD, TP...
INFO_seance_planned : séances planifiée à l'EdT
INFO_seance_to_be_affected : séance à planifier, non affectée à un enseignant. Populé automatiquement à partir de INFO_module_sequence (une séance est une sequence affectée à un groupe d'étuduiant) (A REFACTORISER POUR METTRE LA DEPENDANCE A INFO_module_sequencage)
INFO_semestre : liste des semestres (Note : simple table de numéro indispensable pour une gestion générique et automatique des paramètres)
INFO_statut : liste des statut étuduiants (FISE, FISA...)
INFO_updatable : liste des requètes pour une gestion générique et automatique des tables modifiables
INFO_view : liste des requètes pour une gestion générique et automatique des vues (IHM)

table de liaison

INFO_dependance_sequence : definit quelle séquence (CM, TD, TP ou autre) se place avant quelle autre séquence
INFO_module_as_learning_unit : définit quelle module appartient à quelle unité d'enseignement, un module peut appartenir à plusieurs UE, mais pas 2 fois à la même UE
INFO_seance_to_be_affected_as_enseignant : affectation d'une séance à un enseignant (Note : association 1-1 affin de séparer les droits de modification entre "seance_to_be_affected" et leur affectation)
