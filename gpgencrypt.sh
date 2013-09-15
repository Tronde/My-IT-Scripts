#!/bin/bash

# Verschlüsseln von Text.
# Erforderliche Linux Pakete: gpg, xsel

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
xsel --clipboard | gpg --verbose --encrypt -a --recipient meine@email.de | xsel --clipboard

echo ""
echo ""
echo ""
echo "Clipboard Inhalt nach Verschlüsselung:"
echo "**************************************"
echo ""
xsel --clipboard

# Only works with bash (and not sh):
echo ""
echo ""
echo ""
read -s -n 1 -p "Press any key to continue…"
