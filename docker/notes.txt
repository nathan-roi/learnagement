https://hub.docker.com/r/tomsik68/xampp/

docker run --name myXampp -p 41061:22 -p 41062:80 -d -v ~/my_web_pages:/www tomsik68/xampp

docker run --name myXampp -p 41061:22 -p 41062:80 --p 43306:3306d -v ~/my_web_pages:/www tomsik68/xampp

phpMyAdmin :
CREATE USER 'learnagement'@'%' IDENTIFIED VIA mysql_native_password USING '***';GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, FILE, INDEX, ALTER, CREATE TEMPORARY TABLES, CREATE VIEW, EVENT, TRIGGER, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON *.* TO 'learnagement'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;CREATE DATABASE IF NOT EXISTS `learnagement`;GRANT ALL PRIVILEGES ON `learnagement`.* TO 'learnagement'@'%'; 
