#!/bin/bash
# makeindex Aufruf zur Erstellung des Glossar:
## makeindex -s minimalbsp.ist -t minimalbsp.glg -o minimalbsp.gls minimalbsp.glo
# makeindex Aufruf zur Erstellung des Abkürzungsverzeichnis
## makeindex -s minimalbsp.ist -t minimalbsp.alg -o minimalbsp.acr minimalbsp.acn

# Variablen #####################################################################
Quelldatei=""

# Funktionen ####################################################################

usage()
{
cat << EOF
	usage: $0 options

	Dieses Script fuehrt die makeindex Laeufe fuer LaTeX aus, welche zur
	Erstellung von Glossar und Abkuerzungsverzeichnis benoetigt werden.

	Folgende Variablen muessen angegeben werden:
		Quelldatei

	Die Variablen koennen durch Bearbeitung des Scripts oder durch die folgenden
	Optionen belegt werden.

	OPTIONS:
		-h Zeig diesen Hilfetext
		-Q Name der LaTeX-Quelldatei
EOF
}

# Programmstart ################################################################

while getopts .hQ:. OPTION
do
	case $OPTION in
		h)
			usage
			exit 1
			;;
		Q)
			Quelldatei="${OPTARG}"
			;;
		?)
			usage
			exit
			;;
	esac
done

if [[ -z $Quelldatei ]]; then
	usage
	exit 1
fi 

makeindex -s $Quelldatei.ist -t $Quelldatei.glg -o $Quelldatei.gls $Quelldatei.glo
makeindex -s $Quelldatei.ist -t $Quelldatei.alg -o $Quelldatei.acr $Quelldatei.acn
