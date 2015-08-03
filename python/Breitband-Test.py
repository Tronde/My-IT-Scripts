#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
 Das Programm "Breitband-Test" eignet sich zur Messung der Übertragungsgeschwindigkeit einer Breitband-Verbindung oder jeder andernen Netzwerkverbindung. Die Messdaten werden in einer CSV-Datei protokolliert.

 Dabei kann das Programm komplett in einem Terminal oder von der Konsole aus ausgeführt werden. Die Verwendung eines Webbrowsers ist nicht notwendig.

 Copyright 2015 by Jörg Kastning <joerg.kastning@my-it-brain.de>
"""

import sys, argparse, subprocess, csv

"""
 Funktionen
"""

def icmp(host, count):
    """ Diese Prozedur sendet einige ICMP-Pakete an einen Host. """
    ping_result = subprocess.check_output(["ping", "-c", count, host])
    return ping_result

def clientmodus():
    print "Das Pogramm befindet sich im Clientmodus."
    print "Ausgabe von icmp_count:"
    print(icmp_count)
    print "Ausgabe der ICMP-Requests:"
    print(icmp(host, icmp_count))
    
    f = open('workfile', 'a')
    f.write(icmp(host, icmp_count))
    f.close()
    f = open('workfile', 'r')
    #output = f.readlines()
    print "Ausgabe der Datei:"
    for line in f.readlines():
        sys.stdout.write(line)
    #sys.stdout.flush()
    f.close()

def servermodus():
    print "Das Pogramm befindet sich im Servermodus."

"""
 Erstellung des Parsers und Definition der Argumente
"""

parser = argparse.ArgumentParser(description=" Breitband-Test.py")
parser.add_argument("-S", "--Server", dest="progmodus", action='store_true', default='False', help="Startet das Programm im Servermodus.")
parser.add_argument("-P", "--Port", dest="port", default=500001, help="Port auf dem der Server hört bzw. zu dem sich der Client verbindet.")
parser.add_argument("-C", dest="icmp_count", default='10', help="Anzahl ICMP-Pakete, welche an den Server gesendet werden.")
parser.add_argument("-H", "--Host", dest="Host", required=False, help="IP-Adresse an welche der Server-Socket gebunden wird bzw. zu dem sich der Client verbindet.")

args = parser.parse_args()

progmodus = args.progmodus
port = args.port
icmp_count = args.icmp_count
host = args.Host

if progmodus == True:
    servermodus()
else:
    clientmodus()
