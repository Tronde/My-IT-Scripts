#!/bin/bash
# Shell-Skript zur Erstellung von TLS/SSL-Zertifikaten  mit der Bash
# Originalversion von JP, Bash-Anpassung für Cygwin von MS 2016-05-09,
# Erweiterung von JKA 2016-05-22

# Variablen ################################################################
OPENSSL=openssl

# Funktionen ###############################################################
usage() {
	cat << EOF
	usage: $0 OPTIONS
	Shell-Skript zur Erstellung von TLS/SSL-Zertifikaten  mit der Bash
	Originalversion von JP, Bash-Anpassung für Cygwin von MS 2016-05-09,
	Erweiterung von JKA 2016-05-22

	OPTIONS:
	-c Optional: Gibt den vollstaendigen Pfad zur Konfigurationsdatei mit den Parametern zur CSR-Erzeugung an (z.B. "/var/tmp/test.cfg")
	-f Gibt den FQDN an. Beispiel: "smtp-relay.uni-bielefeld.de"
	-h Zeigt diese Nachricht an.
	-p Gibt den Dateipraefix an. Beispiel: "smtp-relay"
EOF
}

# Hauptteil ################################################################
while getopts .c:f:hp:. OPTION
do
	case $OPTION in
		c)
			CFG="${OPTARG}"
			;;
		p)
			ZERTPREFIX="${OPTARG}"
			;;
		h)
			usage
			exit;;
		f)
			ZERTCN="${OPTARG}"
			;;
		?)
			usage
			exit;;
	esac
done

if [[ -z $ZERTPREFIX ]]; then
	read -p "Filepraefix: " ZERTPREFIX
fi

if [[ -z $ZERTCN ]]; then
	read -p "FQDN: " ZERTCN
fi	

ZERTDN_PREF="/C=DE/ST=Nordrhein-Westfalen/L=Bielefeld/O=Universitaet Bielefeld/OU=HRZ"
S_DN="${ZERTDN_PREF}/CN=${ZERTCN}"
# Fuer den Fall, dass man mal was anderes braucht S_DN explizit setzen: S_DN="/C=DE/O=Universitaet Bielefeld/OU=HRZ/CN=GRP:abuse"
YEAR=`date +"%Y"`
DIR=${ZERTPREFIX}.${YEAR}
PRIV=${ZERTPREFIX}_priv.pem
REQ=${ZERTPREFIX}_request.csr

mkdir -p ${DIR} || exit 73
chmod 700 ${DIR}
cd ${DIR} || exit 73
# falls nicht vorhanden, den privaten Schlüssel anlegen
# Da mkpasswd unter Cygwin/Windows anders arbeitet, nutzen wir hier openssl mit rand-Operator
umask 077; openssl rand -base64 12 > ${ZERTPREFIX}_priv.passwd
umask 077; openssl rand -base64 12 > ${ZERTPREFIX}_revocation.passwd

if [ ! -f $PRIV ]; then
  touch ${PRIV}
  chmod 600 ${PRIV}
	${OPENSSL} genrsa  -passout file:${ZERTPREFIX}_priv.passwd -aes256 -out ${PRIV} 2048
fi
# Request generieren
if [[ -n $CFG ]]; then
	${OPENSSL} req -batch -sha256 -new -key ${PRIV} -passin file:${ZERTPREFIX}_priv.passwd -out ${REQ} -config "${CFG}"
	chmod 600 ${REQ}
else
	${OPENSSL} req -batch -sha256 -new -key ${PRIV} -passin file:${ZERTPREFIX}_priv.passwd -out ${REQ} -subj "${S_DN}"
	chmod 600 ${REQ}
fi

# Request in Textform exportieren (nur zur manuellen Kontrolle)
${OPENSSL} req -text -verify -in ${REQ} > ${REQ}.txt

cat <<EOF > ${ZERTPREFIX}.TODO
# Request /.csr an CA übermitteln
#
# Signiertes File als ${ZERTPREFIX}.pem abspeichern bzw. verlinken ln -s <cert-xyz.pem> ${ZERTPREFIX}.pem
# Sicherungs-/Transportformat ist pkcs12
${OPENSSL} pkcs12 -export -passin file:${ZERTPREFIX}_priv.passwd -inkey $PRIV -in ${ZERTPREFIX}.pem -out ${ZERTPREFIX}.p12
#
# Laufzeit ermitteln
${OPENSSL} x509 -in ${ZERTPREFIX}.pem -enddate -noout
#
# Beispiele für weitere Verarbeitung
# ${OPENSSL} rsa -passin file:${ZERTPREFIX}_priv.passwd -in $PRIV -out $PRIV.unverschluesselt

EOF
