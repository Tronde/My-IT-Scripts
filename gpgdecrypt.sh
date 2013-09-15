#!/bin/bash

# Entschlüsseln von Text.
# Erforderliche Linux Pakete: gpg, xsel

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

# Only works with bash (and not sh):
echo ""
echo ""
echo ""
read -s -n 1 -p "Press any key to continue…"
