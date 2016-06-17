#!/bin/bash
# Beschreibung:
# Dieses Skript gleicht einen RSA-Hash aus dem Log /var/log/secure mit den
# vorhandenen SSH-Public-Keys ab. Bei Uebereinstimmung wird der entsprechende
# Key ausgegeben.
#
# Der RSA-Hash wird dem Skript als Argument uebergeben.
#
# Autor: Joerg Kastning <joerg.kastning(aet)uni-bielefeld(punkt)de>

# Hauptteil #######################################################
rsa_fprint="$1"
printf "RSA-Fingerprint:\n${rsa_fprint}\n\n"
for key in *.pub
do
  tmp1=`/usr/bin/ssh-keygen -lf ${key}`
  set - $tmp1
  tmp2=`echo "$2"`
  if [[ "${rsa_fprint}" = "${tmp2}" ]]
  then
    printf "Der zugehoerige SSH-Key lautet:\n${tmp1}\n"
    exit 0
  fi
done
printf "Es wurde kein SSH-Key gefunden, welcher zu dem uebergebenen RSA-Fingerprint passt."
exit 0
