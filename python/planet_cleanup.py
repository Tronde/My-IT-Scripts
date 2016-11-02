#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
#
# Beschreibung:
# Dieses Skript generiert eine Tabelle der im Planeten aktivierten Blogs, welche seit ueber 12 Monaten inaktiv sind.
# Die Tabelle wird in UU-Wiki-Syntax ausgegeben.
#
# Anleitung:
# Die Blog-Liste (Bloglisten-Hack) muss als HTML-Datei auf dem lokalen
# Rechner gespeichert werden. Den Pfad zu dieser Datei wird der
# Variable 'path' zugewiesen.
#
# Die Variable 'date_inactive' gibt an, ab wann die Blogs wegen Inaktivität aussortiert werden sollen. Beispiel: Mit date_inactive = '2015-11-02' werden alle Blogs ausgegeben, deren letze Aktivität vor dem 02.11.2015 liegt.
#
# Autor:    Tronde (https://ubuntuusers.de/user/Tronde/)
# Lizenz:   GPLv3 (http://www.gnu.de/documents/gpl.de.html)

import re
from bs4 import BeautifulSoup
from datetime import datetime
import locale
locale.setlocale(locale.LC_TIME,'')

path = "/path/to/Blogs.html"
date_inactive = '2015-11-02'
date_set = datetime.strptime(date_inactive, '%Y-%m-%d')

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
<-5 tablestyle="width: 95%;" rowclass="titel"> Angeschriebene Blogs
+++
<rowclass="kopf"; :>Blogname
<:>Benutzer
<:>Letzte Aktivität
<:>Nachricht versendet
<:>Antwort
"""

highlight = False

for i in range(len(str_list)-1):
  if datetime.strptime(re.sub('<[^>]*>', '', str_list[i][3]), '%d. %B %Y %H:%M') < date_set:
    if highlight:
      table += "+++\n"
      table += "[" + list[i].a.get('href') + " " + re.sub('<[^>]*>', '', str_list[i][1]) + "]\n"
      table += "[user:" + re.sub('<[^>]*>', '', str_list[i][2]) + ":]\n"
      table += re.sub('<[^>]*>', '', str_list[i][3]) + "\n"
      table += "\n"
      table += "\n"
    else:
      table += "+++\n"
      table += "[" + list[i].a.get('href') + " " + re.sub('<[^>]*>', '', str_list[i][1]) + "]\n"
      table += "[user:" + re.sub('<[^>]*>', '', str_list[i][2]) + ":]\n"
      table += re.sub('<[^>]*>', '', str_list[i][3]) + "\n"
      table += "\n"
      table += "\n"
    highlight = not(highlight)

table += "}}}"
print(table)
