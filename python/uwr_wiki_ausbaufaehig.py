#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
#
# Beschreibung:
# Dieses Skript erstellt den Quelltext der ausbaufaehigen Wiki-Artikel
# fuer den UWR. Es muessen nur noch die Beschreibungen eingefuegt werden.
#
# Version:  0.2 (2016-06-01)
# Autor:    Tronde (https://ubuntuusers.de/user/Tronde/)
# Lizenz:   GPLv3 (http://www.gnu.de/documents/gpl.de.html)

import re
import random
from urllib.request import urlopen
from bs4 import BeautifulSoup
soup = BeautifulSoup(urlopen('https://wiki.ubuntuusers.de/Wiki/Vorlagen/Ausbauf%C3%A4hig/a/backlinks/'))
div_tag = BeautifulSoup(str(soup.find_all(class_=re.compile("content_tabbar"))))
link_list = []
for link in div_tag.ul.find_all('a'):
    link_list.append(link.text)

rand_list = []
num_to_select = 5
rand_list = random.sample(link_list, num_to_select)

# Erstellung Tabelle
table = """
{{{#!vorlage Tabelle
<rowclass="kopf"; :>Artikel
<:>Beschreibung
+++
"""

highlight = False

for i in rand_list:
    if highlight:
        table += '<rowclass="highlight">[:' + i + ":]\n"
        table += "asbaufähig\n"
        table += "+++\n"
    else:
        table += "[:" + i + ":]\n"
        table += "ausbaufähig\n"
        table += "+++\n"
    highlight = not(highlight)

table += "}}}"

print(table)
