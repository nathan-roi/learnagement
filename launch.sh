#!/bin/bash


# launch docker
#sudo docker run --name learnagement -p 40022:22 -p 40080:80 -p 43306:3306 -d -v $PWD/webApp:/www  tomsik68/xampp 

cd docker

echo "Update docker/docker-compose.yml and webApp/config.php files with new password."
read -p "Then press any key to continue... " -n1 -s

sudo docker-compose

# populate with free data
# populationScript

#populate from ADE
python3 ade2sql.py
