#!/bin/bash
#
# Beschreibung: Zaehlt die Pakete in den Paketquellen
# Lizenz: GPLv3

for f in /var/lib/apt/lists/*Packages; do
  printf '%5d %s\n' $(grep '^Package: ' "$f" | wc -l) ${f##*/}
done | sort -n
