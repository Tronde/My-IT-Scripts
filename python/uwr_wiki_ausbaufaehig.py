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

import urllib.request
from bs4 import BeautifulSoup
soup = BeautifulSoup(urllib.request.urlopen('https://wiki.ubuntuusers.de/Wiki/Vorlagen/Ausbauf%C3%A4hig/a/backlinks/'))
print(soup.prettify())
