#!/bin/bash
#
# Beschreibung: Skript zur Aktualisierung von Roundcube
# Autor: Tronde (E-Mail-Adresse: tronde(at)my-it-brain(Punkt)de)
# Datum: 2016-01-03
# Lizenz: GPLv3

# Variablen
INSTALL_PATH=" " # Pfad zur Roundcube-Installation
RC_DB_NAME=" "
PACKAGE_URL=" " # Download-URL der akutellen Roundcube-Version
MYSQL_ROOT_USER=" "

# Funktionen
check()
	{
  		if [ $1 -gt 0 ]; then
    		echo "Uuups, hier ist was schiefgegangen"
    		echo "exit $1"
    		exit 1
  		fi
	}

do_backup()
	{
		cd $HOME
		echo "Backup des Roundcube-Wurzelverzeichnis"
		tar cjf roundcube_rootdir_`date +"%Y-%m-%d"`.tar.bz2 $INSTALL_PATH/*
		echo "Backup der Roundcube-Datenbank. Sie werden zur Eingabe des Passworts für den MySQL-Root-Benutzer aufgefordert."
		mysqldump -u $MYSQL_ROOT_USER -p $RC_DB_NAME > roundcubedb_`date +"%Y-%m-%d"`.sql
	}

do_upgrade()
	{
		echo "Das Archiv mit der aktuellen Roundcube-Version wird heruntergeladen und entpackt."
		wget $PACKAGE_URL
		tar xf roundcubemail-*.tar.gz
		cd `basename roundcubemail-*.tar.gz .tar.gz`
		echo "Bitte geben Sie das sudo-Passwort des angemeldeten Benutzers ein, wenn Sie dazu aufgefordert werden. Folgen Sie den Anweisungen des Installationsscripts."
		sudo ./bin/installto.sh $INSTALL_PATH
	}

# Programmablauf
do_backup
check $?
do_upgrade
check $?

exit 0
