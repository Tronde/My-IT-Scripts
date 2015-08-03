#!/bin/bash

# Verschlüsseln von Text.
# Erforderliche Linux Pakete: gpg, xsel

# Quelle: Ubuntuusers.de
# Überarbeitet von: Jörg Kastning

usage()
{
cat << EOF
        usage: $0 options

        Dieses Script verschlüsselt mit OpenPGP Text
        in der Zwischenablage und gibt ihn in eine Datei oder die
        Standardausgabe aus.

        Damit die Ausgabe zusätzlich in eine Datei ausgegeben wird,
        muss das Script mit der Option -o aufgerufen werden.

		-m Angabe der Empfänger E-Mailadresse
EOF
}

while getopts .hom:. OPTION
do
        case $OPTION in
                h)
                        usage
                        exit 1
                        ;;
                o)
                        Dateiausgabe="true"
                        ;;
				m)
						Mail="${OPTARG}"
						;;
                ?)
                        usage
                        exit
                        ;;
        esac
done

echo "Clipboard Inhalt vor Verschlüsselung:"
echo "*************************************"
echo ""
xsel --clipboard

echo ""
echo ""
echo ""
echo "Mit GnuPG verschlüsseln ...:"
echo "****************************"
echo ""
xsel --clipboard | gpg --verbose --encrypt -a --recipient $Mail | xsel --clipboard

echo ""
echo ""
echo ""
echo "Clipboard Inhalt nach Verschlüsselung:"
echo "**************************************"
echo ""
xsel --clipboard
if [[ "$Dateiausgabe" == true ]]; then
xsel --clipboard > encrypted.txt
fi

# Only works with bash (and not sh):
echo ""
echo ""
echo ""
read -s -n 1 -p "Press any key to continue…"
