#!/bin/bash

# launch docker
docker run --name myXampp -p 41061:22 -p 41062:80 --p 43306:3306d -v ~/my_web_pages:/www tomsik68/xampp

# create learnagement sql user
#TODO

# create  db
cd db/tools
python3 createDB.py
cd -

# populate with program plan
# populationScript

#populate from ADE
python3 ade2sql.py
