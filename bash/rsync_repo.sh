#!/bin/bash
# Sychronisation von zwei Paketquellen auf dem lokalen Spiegelserver
# Autor: Joerg Kastning <joerg.kastning@uni-bielefeld.de>

# Variablen ########################################################
LOG="/var/log/rsync_repo.log"
PACKAGELIST_PATH=""

# Funktionen #######################################################
usage()
{
  cat << EOF
  usage: $0 OPTIONS
  Dieses Skript sychronisiert den Verzeichnisinhalt von zwei
  Paketquellen auf dem  Spiegelserver.

  OPTIONS:
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
  rsync -avx --link-dest=$QUELLE $QUELLE/ $ZIEL
  cd $ZIEL
  createrepo -v --database $ZIEL
}

do_sync_pkg()
{
  while read line
  do
     cp -al $QUELLE/$line $ZIEL
  done < $PACKAGELIST_PATH
  cd $ZIEL
  createrepo -v --database $ZIEL
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

if [[ -z $QUELLE ]]; then
  read -p "Bitte das Quellverzeichnis eingeben: " QUELLE
fi

if [[ -z $ZIEL ]]; then
  read -p "Bitte das Quellverzeichnis eingeben: " ZIEL
fi

if [[ ! -z $PACKAGELIST_PATH ]]; then
  echo \# `date +%Y-%m-%d` - START RSYNC \# > $LOG
  do_sync_pkg
  check $? >> $LOG
  echo \# `date +%Y-%m-%d` - END RSYNC \# >> $LOG
else
  echo \# `date +%Y-%m-%d` - START RSYNC \# > $LOG
  do_sync_repo >> $LOG
  check $? >> $LOG
  echo \# `date +%Y-%m-%d` - END RSYNC \# >> $LOG
fi

exit 0
