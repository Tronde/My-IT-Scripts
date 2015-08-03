#!/bin/bash
# Default Gateway mit dem Kommando route hinzufügen
# Author: Joerg Kastning
# Lizenz: GPLv3

# Funktionen ##################################################################
usage()
{
	cat << EOF
	usage: $0 OPTIONS
	Dieses Script fügt der Routing-Tabelle den Eintrag für
	ein Standardgateway hinzu.
	
	OPTIONS:
	-h Zeigt diese Nachricht an.
	-a <IP-Adresse> Gibt die IP-Adresse des Standardgateways an.
	-i <Interface> Gibt die Schnittstelle (z.B. wlan0) an.
EOF
}

# Beginn des Skripts ##########################################################
while getopts .h:a:i:. OPTION
do
	case $OPTION in
		h)
			usage
			exit;;
		a)
			address="${OPTARG}"
			;;
		i)
			interface="${OPTARG}"
			;;
		?)
			usage
			exit;;
	esac
done

if [[ -z $address ]]; then
	read -p "Bitte die IP-Adresse des Standardgateways eingeben: " address
fi

if [[ -z $interface ]]; then
	read -p "Bitte die Schnitstelle (z.B. wlan0)  eingeben: " interface
fi

route | grep default > /dev/null

if [[ $? == 1 ]]; then
	route add default gw $address $interface
fi
exit
