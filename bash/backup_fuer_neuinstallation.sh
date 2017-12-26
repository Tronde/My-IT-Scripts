#!/bin/bash
#######################################
# Autor: Jörg Kastning                #
# Datum: 2015-06-19                   #
# Lizenz: GPLv3                       #
#######################################

# Beschreibung:
# Dieses Skript sichert eine Liste der
# installierten Programme, um diese auf
# einem neuen System einfach wiederher-
# stellen zu können.
#
# Darüber hinaus wird das persönliche
# HOME-Verzeichnis inkl. versteckter
# Dateien und Ordner gesichert.

# Variablen ###########################

QUELLE="/home/USERNAME" # Pfad zum persönlichen HOME-Verzeichnis
ZIEL="/media/USERNAME/HDD500GB1" # Pfad zu einem externen Ziellaufwerk

# Paketliste zur Wiederherstellung sichern

cd $QUELLE
dpkg --get-selections | awk '!/deinstall|purge|hold/ {print $1}' > packages.list.save
apt-mark showauto > package-states-auto
apt-mark showmanual > package-states-manual
find /etc/apt/sources.list* -type f -name '*.list' -exec bash -c 'echo -e "\n## $1 ";grep "^[[:space:]]*[^#[:space:]]" ${1}' _ {} \; > sources.list.save
cp /etc/apt/trusted.gpg trusted-keys.gpg
cp -R /etc/apt/trusted.gpg.d trusted.gpg.d.save

# HOME-Verzeichnis sichern
tar -cf $ZIEL/backup.tar $Quelle/

exit 0
