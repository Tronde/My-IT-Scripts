#!/bin/bash

# Entschlüsseln von Text.
# Erforderliche Linux Pakete: gpg, xsel

# Quelle des Scripts: Ubuntuusers.de
# Ueberarbeitet von: Joerg Kastning

usage()
{
cat << EOF
	usage: $0 options

	Dieses Script entschlüsselt mit OpenPGP verschlüsselten Text
	in der Zwischenablage und gibt ihn in eine Datei oder die
	Standardausgabe aus.

	Damit die Ausgabe zusätzlich in eine Datei ausgegeben wird,
	muss das Script mit der Option -o aufgerufen werden.
EOF
}

while getopts .ho. OPTION
do
	case $OPTION in
		h)
			usage
			exit 1
			;;
		o)
			Dateiausgabe="true"
			;;
		?)
			usage
			exit
			;;
	esac
done

echo "Clipboard Inhalt vor Entschlüsselung:"
echo "*************************************"
echo ""
xsel --clipboard

echo ""
echo ""
echo ""
echo "Mit GnuPG entschlüsseln ...:"
echo "****************************"
echo ""
xsel --clipboard | gpg --verbose --decrypt -a | xsel --clipboard

echo ""
echo ""
echo ""
echo "Clipboard Inhalt nach Entschlüsselung:"
echo "**************************************"
echo ""
xsel --clipboard
if [[ "$Dateiausgabe" == true ]]; then
xsel --clipboard > decrypted.txt
fi

# Only works with bash (and not sh):
echo ""
echo ""
echo ""
read -s -n 1 -p "Press any key to continue…"
