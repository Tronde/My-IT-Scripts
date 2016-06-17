#!/bin/bash
#
# Beschreibung: Skript zur Anlage eigener YUM-Repositories
# Autor: Joerg Kastning <joerg.kastning@uni-bielefel.de>

# Variablen ###################################################################
HOST="http://rpm-repo.hrz.uni-bielefeld.de" # Adresse lokaler Spiegelserver
BASEDIR="/var/www/html/local-rhel-7-repo/"
REPONAME=""
LOG="/var/log/create_yum_repo.log"

# Funktionen ##################################################################
usage()
{
  cat << EOF
  usage: $0 OPTIONS
  Dieses Skript legt ein neues YUM-Repository
  auf dem lokalen Server an.
  
  Vor dem ersten Lauf müssen die Variablen BASEDIR und HOST definiert werden.
  Die Variable REPONAME kann entweder im Skript definiert werden, oder als
  Parameter beim Aufruf des Skripts mit übergeben werden.

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

#cat >> $BASEDIR/$REPONAME.repo << EOF
#[$REPOID]
#name= RHEL \$releasever - \$basearch (local)
#baseurl=$HOST/`basename $BASEDIR`/$REPONAME/
#enabled=1
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
#EOF
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
