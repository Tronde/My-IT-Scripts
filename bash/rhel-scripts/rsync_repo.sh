#!/bin/bash
# Sychronisation von zwei Paketquellen auf dem lokalen Spiegelserver
# Autor: Joerg Kastning <joerg.kastning(aet)uni-bielefeld(punkt)de>

# Variablen ########################################################
LOG="/var/log/rsync_repo.log"
BASEDIR="/var/www/html/local-rhel-7-repo/"
PACKAGELIST_PATH=""

# Funktionen #######################################################
usage()
{
  cat << EOF
  usage: $0 OPTIONS
  Dieses Skript sychronisiert den Verzeichnisinhalt von zwei
  Paketquellen auf dem  Spiegelserver.

  OPTIONS:
  -f Übergibt eine Datei mit zu synchronisierenden Paketen
  -h Zeigt den Hilfetext an
  -Q Gibt das zu synchronisierende Quellverzeichnis an
  -Z Gibt das Zielverzeichnis der Synchronisation an
EOF
}

check()
{
  if [ $1 -gt 0 ]; then
    echo "Uuups, hier ist was schiefgegangen"
    echo "exit $1"
    exit 1
  fi
}

do_sync_repo()
{
  rsync -avx --link-dest=$BASEDIR$QUELLE $BASEDIR$QUELLE/ $BASEDIR$ZIEL
  cd $BASEDIR$ZIEL
  createrepo -v --database $BASEDIR$ZIEL
}

do_sync_pkg()
{
  while read line
  do
     cp -al $line $BASEDIR$ZIEL/Packages
  done < $PACKAGELIST_PATH
  cd $BASEDIR$ZIEL/Packages
  createrepo -v --database $BASEDIR$ZIEL/Packages
}

# Hauptteil #######################################################
while getopts .h:Q:Z:f:. OPTION
do
  case $OPTION in
    h)
       usage
       exit;;
    Q)
       QUELLE="${OPTARG}"
       ;;
    f)
       PACKAGELIST_PATH="${OPTARG}"
       ;;
    Z)
       ZIEL="${OPTARG}"
       ;;
    ?)
       usage
       exit;;
  esac
done

if [[ -z $QUELLE && -z $PACKAGELIST_PATH ]]; then
  read -p "Bitte das Quellverzeichnis eingeben: " QUELLE
fi

if [[ -z $ZIEL ]]; then
  read -p "Bitte das Quellverzeichnis eingeben: " ZIEL
fi

if [[ ! -z $PACKAGELIST_PATH ]]; then
  echo \# `date +%Y-%m-%dT%H:%M` - START RSYNC \# > $LOG
  do_sync_pkg >> $LOG
  check $? >> $LOG
  echo \# `date +%Y-%m-%dT%H:%M` - END RSYNC \# >> $LOG
else
  echo \# `date +%Y-%m-%dT%H:%M` - START RSYNC \# > $LOG
  do_sync_repo >> $LOG
  check $? >> $LOG
  echo \# `date +%Y-%m-%dT%H:%M` - END RSYNC \# >> $LOG
fi

exit 0
