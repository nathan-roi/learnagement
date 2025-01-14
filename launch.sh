#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

##########
# init web app config
cd webApp/db_connection
if [ ! -f config.php ]
then
    cp config.php.example config.php
    printf "${GREEN}Update docker/docker-compose.yml and webApp/db_connection/config.php files with new password.${NC}"
    echo
    read -p "Then press any key to continue... " -n1 -s
    echo    
fi
if cmp --silent -- config.php.example config.php
then
    printf "${RED}WARNING default password seems to be used !!!${NC}"
    echo
fi
cd ../..

##########
# create links to populate with private data

# create private data directory if not exist
mkdir -p db/data
cd db
sh insertPrivateData.sh
cd ..


##########
# launch docker
#sudo docker run --name learnagement -p 40022:22 -p 40080:80 -p 43306:3306 -d -v $PWD/webApp:/www  tomsik68/xampp 


cd docker
if [ ! -f docker-compose.yml ]
then
    cp docker-compose.yml.example docker-compose.yml
    printf "${GREEN}Update docker/docker-compose.yml and webApp/db_connection/config.php files with new password.${NC}"
    echo
    read -p "Then press any key to continue... " -n1 -s
    echo
fi
if cmp --silent -- docker-compose.yml.example docker-compose.yml
then
    printf "${RED}WARNING default password seems to be used !!!${NC}"
    echo
fi

sudo docker-compose up #-d : lance docker en arrière plan

sleep 5

sudo docker-compose ps

cd ..

# populate with free data
# populationScript

#populate from ADE
#python3 ade2sql.py
