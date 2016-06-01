#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
#
# Beschreibung:
# Dieses Skript erstellt den Quelltext der ausbaufaehigen Wiki-Artikel
# fuer den UWR.
#
# Version:  0.1 (2016-05-22)
# Autor:    Tronde (https://ubuntuusers.de/user/Tronde/)
# Lizenz:   GPLv3 (http://www.gnu.de/documents/gpl.de.html)

import re
from urllib.request import urlopen
from bs4 import BeautifulSoup
soup = BeautifulSoup(urlopen('https://wiki.ubuntuusers.de/Wiki/Vorlagen/Ausbauf%C3%A4hig/a/backlinks/'))
div_tag = BeautifulSoup(str(soup.find_all(class_=re.compile("content_tabbar"))))
link_list = []
link_list = div_tag.ul.find_all("li")
print(link_list)
