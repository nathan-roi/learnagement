#!/bin/bash


# launch docker
sudo docker run --name learnagement -p 40022:22 -p 40080:80 -p 43306:3306 -d -v $PWD/webApp:/www -v $PWD/db/data:/opt/lampp/var/mysql/ tomsik68/xampp 

echo "Don't use given password !!!"

echo "Connect to PHPMyAdmin: http://localhost:41062/phpmyadmin/"
echo "add user using SQL command: CREATE USER 'learnagement'@'%' IDENTIFIED BY 'L3*rn*g3m3ntP4ssw0rd';"
echo "Update your config.py file (see config.skeleton) with new password."
echo "Change the MySQL admin passwd using SQL command: ALTER USER 'root'@'localhost' IDENTIFIED BY 'R00tN3wP4ssw0rd';"
read -p "Then press any key to continue... " -n1 -s

# create  db
python3  db/tools/createDB.py


# populate with free data
# populationScript

#populate from ADE
python3 ade2sql.py
