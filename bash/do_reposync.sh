#!/bin/bash
#
# Beschreibung: Skript zur Anlage des RHEL-Repositories
#               auf dem Spiegelserver
# Autor: Joerg Kastning <joerg.kastning@uni-bielefel.de>

LOG="/var/log/do_reposync.log"

echo \# `date +%Y-%m-%d` - START REPOSYNC \# > $LOG

reposync --gpgcheck -l --repoid=rhel-7-server-rpms --download_path=/var/www/html/local-rhel-7-repo --downloadcomps --download-metadata -n >> $LOG

echo \# `date +%Y-%m-%d` - END REPOSYNC \# >> $LOG
echo \# `date +%Y-%m-%d` - START CREATEREPO \# >> $LOG

cd /var/www/html/local-rhel-7-repo/rhel-7-server-rpms/
createrepo -v /var/www/html/local-rhel-7-repo/rhel-7-server-rpms/ -g comps.xml >> $LOG

echo \# `date +%Y-%m-%d` - END CREATEREPO \# >> $LOG

exit 0
