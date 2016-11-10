#!/usr/bin/python


# Script pour telecharger City

import MySQLdb

file_ = open('city.csv', 'w')
file_.write ('city_id,city,country_id\n')
db = MySQLdb.connect( user='etudiants',
                      passwd='etudiants_1',
                      host='192.168.99.100',
                      db='sakila')

cur = db.cursor()

cur.execute("SELECT * FROM city")

for row in cur.fetchall():
    file_.write(str(row[0])+','+ row[1]+','+ str(row[2])+'\n')

db.close()
file_.close()
