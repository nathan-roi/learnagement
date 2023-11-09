#!/bin/sh
 
FILE=learnagement.`date +"%Y%m%d"`.sql
DBSERVER=127.0.0.1
PORT=43306
DATABASE=learnagement
USER=root
PASS=Root2Change
 
unalias rm     2> /dev/null
rm ${FILE}     2> /dev/null
rm ${FILE}.gz  2> /dev/null
 
mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} --port=${PORT} ${DATABASE} > ${FILE}

gzip $FILE
echo "${FILE}.gz was created:"
ls -l ${FILE}.gz
