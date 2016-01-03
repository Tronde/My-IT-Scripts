#!/bin/bash
# Name: rsync-doc.sh
# Author: Joerg Kastning
# License: GPLv3
# URL: https://github.com/Tronde/My-IT-Scripts/blob/master/bash/rsync-doc.sh
#
# This script synchronize remote directorys with a directory on the local host.
# It was build to enable almost everyone to add new directories to the script,
# which should be synced.

# Variables ###################################################################

SMB_SOURCE="//<FQDN>/<SHARE_NAME>"
MOUNTPOINT="/mnt/<NAME>"
CREDENTIALS="/<PATH>/<TO>/.smbcredentials"
SOURCES=(/DIR1 /DIR2 )
TARGET="/<TARGEDTDIR/"
RSYNCCONF=(-az --delete-delay)

# Functions ###################################################################

do_mount()
	{
		mount -o credentials=$CREDENTIALS,ro -t cifs $SMB_SOURCE $MOUNTPOINT
	}

do_rsync()
	{
		for SOURCE in "${SOURCES[@]}"; do
			rsync "${RSYNCCONF[@]}" $MOUNTPOINT$SOURCE $TARGET
		done
	}

do_unmount()
	{
		umount $MOUNTPOINT
	}

# Program #####################################################################

do_mount
do_rsync
do_unmount

exit 0
