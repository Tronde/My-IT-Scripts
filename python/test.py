#!/usr/bin/python
# -*- coding: utf-8 -*-

import argparse, subprocess

def icmp(host):
     """ Diese Prozedur sendet einige ICMP-Pakete an einen Host. """
     ping_result = subprocess.check_output(["ping", "-c 4", host])
     return ping_result

parser = argparse.ArgumentParser(description=" test.py")
parser.add_argument("-H", "--Host", dest="Host", required=False)

args = parser.parse_args()

host = args.Host

print "Ausgabe der ICMP-Requests:"
print(icmp(host))

f = open('workfile', 'a')
f.write(icmp(host))
f.close()
f = open('workfile', 'r')
#output = f.readlines()
print "Ausgabe der Datei:"
for line in f.readlines():
    print(line)
f.close()
