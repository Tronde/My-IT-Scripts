#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
#
# Beschreibung:
# Dieses Skript generiert eine Tabelle der im Planeten aktivierten Blogs.
# Die Tabelle wird in UU-Wiki-Syntax ausgegeben.
#
# Die Blogs mit einer Inaktivitaet > 12 Monate muessen manuell herausge-
# filtert werden.
#
# Anleitung:
# Die Blog-Liste (Bloglisten-Hack) muss als HTML-Datei auf dem lokalen
# Rechner gespeichert werden. Den Pfad zu dieser Datei wird der
# Variable 'path' zugewiesen.
#
# Autor:    Tronde (https://ubuntuusers.de/user/Tronde/)
# Lizenz:   GPLv3 (http://www.gnu.de/documents/gpl.de.html)

import re
from bs4 import BeautifulSoup

path = "/path/to/Blogs.html"

soup = BeautifulSoup(open(path))
blog_table = BeautifulSoup(str(soup.body.table.tbody.find_all('tr', class_='')))
list = []

for item in blog_table.find_all('tr'):
  list.append(item)

str_list = []
for i in range(len(list)):
  test = str(list[i])
  str_list.append(test.splitlines())

# Erstellung Tabelle
table = """
{{{#!vorlage Tabelle
<rowclass="kopf"; :>Blogname
<:>Benutzer
<:>Letzte Aktivität
"""

highlight = False

for i in range(len(str_list)-1):
  if highlight:
    table += "+++\n"
    table += re.sub('<[^>]*>', '', str_list[i][1]) + "\n"
    table += "[user:" + re.sub('<[^>]*>', '', str_list[i][2]) + ":]\n"
    table += re.sub('<[^>]*>', '', str_list[i][3]) + "\n"
  else:
    table += "+++\n"
    table += re.sub('<[^>]*>', '', str_list[i][1]) + "\n"
    table += "[user:" + re.sub('<[^>]*>', '', str_list[i][2]) + ":]\n"
    table += re.sub('<[^>]*>', '', str_list[i][3]) + "\n"
  highlight = not(highlight)

table += "}}}"
print(table)
