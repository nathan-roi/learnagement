from ics import Calendar
import requests
import mysql.connector
import config 

reqEnseignants = "SELECT id, nom, prenom FROM INFO_enseignant"
reqModule = "SELECT id, code FROM INFO_module"

enseignants = {}
with mysql.connector.connect(**config.connection_params) as db :
    with db.cursor() as c:
        c.execute(reqEnseignants)
        resultats = c.fetchall()
        for enseignant in resultats:
            enseignants[enseignant[1].upper()+ " "+enseignant[2].upper()] = enseignant[0]
 


# Parse the URL
url = config.adeLinks['VERNIER FLAVIEN']
cal = Calendar(requests.get(url).text)
 
# Print all the events
for event in cal.events:
    #print("begin: ", event._begin)
    #print("end: ", event._end_time)
    #print("name: ", event.name)
    #print("desc: ", event.description)
    #print()

    for enseignant in enseignants.keys():
        if enseignant in event.description:
            print(enseignant, event.name)
