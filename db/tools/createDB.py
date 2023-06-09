from ics import Calendar
import requests
import mysql.connector
import config 

def executeScriptsFromFile(cursor, filename):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        try:
            if command.strip() != '':
                cursor.execute(command)
        except IOError as e:
            print("Command skipped: ", e)

sqlSkeleton = "sql/skeleton.sql"
with mysql.connector.connect(**config.connection_params) as db :
    with db.cursor() as c:
        executeScriptsFromFile(c, sqlSkeleton)

