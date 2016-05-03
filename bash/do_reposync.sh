#!/bin/bash
#
# Beschreibung: Skript zur Synchronisierung des RHEL-Repositories
#               auf dem Spiegelserver
# Autor: Joerg Kastning <joerg(Punkt)kastning(aet)uni-bielefeld.de>

LOG="/var/log/do_reposync.log"
REPOID=" "
DOWNLOADPATH=" "

echo \# `date +%Y-%m-%d` - START REPOSYNC \# > $LOG

for REPO in "${REPOID[@]}"
  do
    reposync --gpgcheck -l --repoid=$REPO --download_path=/var/www/html/$DOWNLOADPATH --downloadcomps --download-metadata -n >> $LOG
    cd /var/www/html/$DOWNLOADPATH/$REPO
    createrepo -v /var/www/html/$DOWNLOADPATH/$REPO -g comps.xml >> $LOG
done

echo \# `date +%Y-%m-%d` - END REPOSYNC \# >> $LOG
exit 0
