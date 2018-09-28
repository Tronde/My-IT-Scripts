#!/bin/sh
# Beschreibung:
# Wrapper-Skript zur Ausfuehrung von Tests mit iperf3

# Variablen ##################################################################
RHOST="${1}"
IPV="${2}"
DIRECT="${3}"
PORT="${4}"
# Funktionen #################################################################
usage(){
	cat << EOF
        usage: $0 ARG1 ARG2 ARG3 ARG4
		Wrapper-Skript zur Ausfuehrung von Tests mit iperf3

        Argumente:
		ARG1	FQDN des entfernten Rechners
		ARG2	IPv4/IPv6 anzugeben als '4' oder '6'
		ARG3	Testrichtung 'F'orward oder 'R'everse
		ARG4	Port auf Serverseite (Default 5201)
EOF
}

ipv4(){
	LOG="/var/tmp/iperf3_${RHOST}_${IPV}_${DIRECT}_`date +%Y-%m-%dT%H:%M`.log"
	echo "Start `date +%Y-%m-%dT%H:%M`" >$LOG
	if [ "${DIRECT}" = "F" ]
	then
		iperf3 -c ${RHOST} -4 -V --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V --port ${PORT} -w 1024k 2>&1 >>$LOG
	fi
	if [ "${DIRECT}" = "R" ]
	then
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -4 -V -R --port ${PORT} -w 1024k 2>&1 >>$LOG
	fi
}

ipv6(){
	LOG="/var/tmp/iperf3_${RHOST}_${IPV}_${DIRECT}_`date +%Y-%m-%dT%H:%M`.log"
	echo "Start `date +%Y-%m-%dT%H:%M`" >$LOG
	if [ "${DIRECT}" = "F" ]; then
		iperf3 -c ${RHOST} -6 -V --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V --port ${PORT} -w 1024k 2>&1 >>$LOG
	fi
	if [ "${DIRECT}" = "R" ]
	then
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 64k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 128k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 256k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 512k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 1024k 2>&1 >>$LOG
		iperf3 -c ${RHOST} -6 -V -R --port ${PORT} -w 1024k 2>&1 >>$LOG
	fi
}

# Hauptprogramm ##############################################################
if [ -z "${1}" ] || [ -z "${2}" ]  || [ -z "${3}" ]
then
	echo "ERROR: Mindestens ein Argument fehlt!"
	usage
	exit
fi

if [ "${2}" = "4" ]
then
	ipv4
fi

if [ "${2}" = "6" ]
then
	ipv6
fi
