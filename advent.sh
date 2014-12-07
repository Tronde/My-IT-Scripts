#!/bin/bash
Advent1=113014
Advent2=120714
Advent3=121414
Advent4=122114
erster=14
zweiter=15
dritter=18
vierter=23

init_leds()
{
	for i in $erster $zweiter $dritter $vierter
	do
		gpio -g mode $i out
		gpio -g write $i 0
	done
}

set_leds()
{
	if [ $datum -ge $Advent4 ]
		then
			gpio -g write $erster 1
			gpio -g write $zweiter 1
			gpio -g write $dritter 1
			gpio -g write $vierter 1
		elif [ $datum -ge $Advent3 ]
		then
			gpio -g write $erster 1
			gpio -g write $zweiter 1
			gpio -g write $dritter 1
		elif [ $datum -ge $Advent2 ]
		then
			gpio -g write $erster 1
			gpio -g write $zweiter 1
		elif [ $datum -ge $Advent1 ]
		then
			gpio -g write $erster 1
		else
			init_leds
	fi
}

cleanup()
{
	init_leds
	exit 0
}

init_leds

trap cleanup INT TERM KILL

while :
do
	datum=`date +%m%d%y`
	set_leds
	sleep 86400
done
