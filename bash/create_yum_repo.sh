#!/bin/bash
#
# Beschreibung: Skript zur Anlage eigener YUM-Repositories
# Autor: Joerg Kastning <joerg(PUNKT)kastning(AET)uni-bielefeldde>

# Variablen ###################################################################
HOST="http://<FQDN>" # Adresse des Servers, welcher das Repository hostet.
BASEDIR="/var/www/html/<VERZEICHNISNAME>/"
REPONAME=""
LOG="/var/log/create_yum_repo.log"

# Funktionen ##################################################################
usage()
{
  cat << EOF
  usage: $0 OPTIONS
  Dieses Skript legt ein neues YUM-Repository
  auf dem lokalen Server an.

  OPTIONS:
  -h Zeigt den Hilfetext an
  -r <repo-name> Name des Repositories. Darf keine Leerzeichen enthalten und
     ausschliesslich aus den Zeichen A..Z, a..z, 0..9 sowie "-" bestehen.
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

create_repo()
{
mkdir $BASEDIR$REPONAME
createrepo --database $BASEDIR$REPONAME 
REPOID=`echo $REPONAME | tr "[a-z]" "[A-Z]"`

cat >> $BASEDIR/hrz.repo << EOF
[$REPOID]
name= RHEL \$releasever - \$basearch (local)
baseurl=$HOST/`basename $BASEDIR`/$REPONAME/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
}

# Hauptteil #######################################################
while getopts .h:r:. OPTION
do
  case $OPTION in
    h)
       usage
       exit;;
    r)
       REPONAME="${OPTARG}"
       ;;
    ?)
       usage
       exit;;
  esac
done

if [[ -z $REPONAME ]]; then
  read -p "Bitte den Repository-Namen eingeben: " REPONAME
fi

echo \# `date +%Y-%m-%d` - START SYNC \# > $LOG
create_repo >> $LOG
check $? >> $LOG
echo \# `date +%Y-%m-%d` - END SYNC \# >> $LOG
exit 0
