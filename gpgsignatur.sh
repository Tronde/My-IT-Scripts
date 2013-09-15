#!/bin/bash

# Signieren von Text.
# Erforderliche Linux Pakete: gpg, xsel

echo "Clipboard Inhalt vor Signierung:"
echo "********************************"
echo ""
xsel --clipboard

echo ""
echo ""
echo ""
echo "Mit GnuPG signieren ...:"
echo "************************"
echo ""
xsel --clipboard | gpg --clearsign --detach-sign -a | xsel --clipboard

echo ""
echo ""
echo ""
echo "Clipboard Inhalt nach Signierung:"
echo "*********************************"
echo ""
xsel --clipboard

echo ""
echo ""
echo ""
echo "Signatur prüfen ...:"
echo "************************"
echo ""
xsel --clipboard | gpg --verify -a | xsel --clipboard

# Only works with bash (and not sh):
echo ""
echo ""
echo ""
read -s -n 1 -p "Press any key to continue…"
