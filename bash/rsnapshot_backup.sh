#!/bin/bash
# Name: rsnapshot_backup.sh
# Author: Jörg Kastning
# License: GPLv3
#
# Dieses Script fuehrt ein Backup mit rsnapshot aus. Vor der Ausfuehrung prueft
# das Script ob alle benoetigten Programmkomponenten installiert sind.

# Variablen ###################################################################

MOUNTPOINT=

# Funktionen ##################################################################

check_paketstatus()
  {
    if ! dpkg-query -s rsnapshot 2>/dev/null|grep -qs installed; then
      echo "ERROR - Das Paket rsnapshot ist nicht installiert."
      exit 1
    fi
  }

check_mountpoint()
  {
    if ! grep -qs '$MOUNTPOINT' /proc/mounts; then
      echo "ERROR - Das Backupziel $MOUNTPOINT ist nicht eingehaengt.
      exit 1
    fi
  }

# Programmablauf ##############################################################
