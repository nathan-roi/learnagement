# learnagement
Learning management

L'App Web s'organise autour de 3 objectifs: la gestion du planing prévisionel des enseignants, la cohérence entre le MCCC le prévisionel et la planification réelle, et la gestion des abscences des étudiants.

## Installation et lancement

"launch.sh" lance l'app Web (LAMP) sous docker

## Arrêt de l'app

L'app s'arrête, sans perte de donnée, vie la commande : "sudo docker-compose down"

## Netoyage de l'app

Dans le sous-répertoire docker, le script "destroy.sh", efface toutes les données de l'app et l'arrête. Attention il n'y a pas de moyen de récupération si vous n'avez pas fait de sauvegarde.


