#!/bin/bash



cat sql/table_skeleton.sql > tmp.sql
cat sql/view_skeleton.sql >> tmp.sql

cat freeData/INFO_enseignant.sql >> tmp.sql
#cat freeData/INFO_etudiant.sql >> tmp.sql
cat freeData/INFO_filiere.sql >> tmp.sql
cat freeData/INFO_module.sql >> tmp.sql
cat freeData/INFO_promo.sql >> tmp.sql
cat freeData/INFO_module_as_promo.sql >> tmp.sql
