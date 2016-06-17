#!/bin/bash
#
# Beschreibung: Skript zur Synchronisierung des RHEL-Repositories
#               auf dem Spiegelserver
# Autor: Joerg Kastning <joerg.kastning@uni-bielefel.de>

LOG="/var/log/do_reposync.log"
REPOID=(rhel-7-server-rpms)
DOWNLOADPATH="/var/www/html/local-rhel-7-repo"

echo \# `date +%Y-%m-%dT%H:%M` - START REPOSYNC \# > $LOG

for REPO in "${REPOID[@]}"
  do
    reposync --gpgcheck -l --repoid=$REPO --download_path=/var/www/html/$DOWNLOADPATH --downloadcomps --download-metadata -n >> $LOG
    cd /var/www/html/$DOWNLOADPATH/$REPO
    if [[ -e comps.xml ]]; then
      createrepo -v /var/www/html/$DOWNLOADPATH/$REPO -g comps.xml >> $LOG
    else
      createrepo -v /var/www/html/$DOWNLOADPATH/$REPO >> $LOG
    fi
done

echo \# `date +%Y-%m-%dT%H:%M` - END REPOSYNC \# >> $LOG
exit 0
