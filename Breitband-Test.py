#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
 Das Programm "Breitband-Test" eignet sich zur Messung der Übertragungsgeschwindigkeit einer Breitband-Verbindung oder jeder andernen Netzwerkverbindung. Die Messdaten werden in einer CSV-Datei protokolliert.

 Dabei kann das Programm komplett in einem Terminal oder von der Konsole aus ausgeführt werden. Die Verwendung eines Webbrowsers ist nicht notwendig.

 Copyright 2015 by Jörg Kastning <joerg.kastning@my-it-brain.de>
"""

import sys, argparse, csv

"""
 Erstellung des Parsers und Definition der Argumente
"""

parser = argparse.ArgumentParser(description=" Breitband-Test.py")
