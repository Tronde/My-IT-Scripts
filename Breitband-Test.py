#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
 Das Programm "Breitband-Test" eignet sich zur Messung der Übertragungsgeschwindigkeit einer Breitband-Verbindung oder jeder andernen Netzwerkverbindung. Die Messdaten werden in einer CSV-Datei protokolliert.

 Dabei kann das Programm komplett in einem Terminal oder von der Konsole aus ausgeführt werden. Die Verwendung eines Webbrowsers ist nicht notwendig.

 Copyright 2015 by Jörg Kastning <joerg.kastning@my-it-brain.de>
"""

import sys, argparse, csv

"""
 Funktionen
"""

def clientmodus():
    print "Das Pogramm befindet sich im Clientmodus."

def servermodus():
    print "Das Pogramm befindet sich im Servermodus."

"""
 Erstellung des Parsers und Definition der Argumente
"""

parser = argparse.ArgumentParser(description=" Breitband-Test.py")
parser.add_argument("-s", "--server", dest="progmodus", action='store_true', default='False', help="Startet das Programm im Servermodus.")

args = parser.parse_args()

progmodus = args.progmodus
print progmodus

if progmodus == True:
    servermodus()
else:
    clientmodus()
