#!/usr/bin/env bash

if [ -v $1 ] || [ -v $2 ] || [ -v $3 ]; then
	echo -e "Usage: $(basename $0) [latitude] [longitude] [wallpaper path]\n"
	echo -e "This script requires 'feh' for setting the wallpaper and 'sunwait' to calculate sunrise/set."
	echo -e "They can either be somewhere in your \$PATH or in the same directory as this script.\n"
	echo -e "latitude/longigude are expressed in floating-point degrees, with [NESW] appended\n"
	echo -e "the wallpaer directory has to contain image files with this name structure:"
	echo -e "[name][dawn|day|dusk|night]"
	echo -e "example:" 	
	echo -e " \tnowPaper/"
    echo -e " \t├── Canyondawn.png"
    echo -e " \t├── Canyonday.png"
    echo -e " \t├── Canyondusk.png"
    echo -e " \t└── Canyonnight.png\n"
	echo -e "Options:"
	echo -e " -o \tOne Shot mode (set wallpaper and exit)"
	echo -e "\nCommand exapmle:"
	echo -e "\t$(basename $0) 48.20849N 16.37208E ~/wallpapers/nowPaper"
	exit 1
fi

LAT=$1
LONG=$2
WPDIR=$3

while true; do
	if [ "$LASTRUN" != "$(date +%F)" ]; then
		LASTRUN=$(date +%F)
		DAWN=$(./sunwait -p $LAT $LONG | grep "Civil twilight starts" |grep -Eo '[0-9]{1,4}' | head -n1)
		DAY=$(./sunwait -p $LAT $LONG | grep "Sun rises" |grep -Eo '[0-9]{1,4}' | head -n1)
		DUSK=$(./sunwait -p $LAT $LONG | grep "Sun rises" |grep -Eo '[0-9]{1,4}' | tail -n1)
		NIGHT=$(./sunwait -p $LAT $LONG | grep "Civil twilight starts" |grep -Eo '[0-9]{1,4}' | tail -n1)
	fi


	DAWNPAPER=($WPDIR/*dawn*)
	DAYPAPER=($WPDIR/*day*)
	DUSKPAPER=($WPDIR/*dusk*)
	NIGHTPAPER=($WPDIR/*night*)

	TIME=$(date +"%H%M")
	
	if [ $TIME -ge $DAWN ] && [ $TIME -lt $DAY ]; then
	    feh --bg-scale ${DAWNPAPER[1]}
	fi

	if [ $TIME -ge $DAY ] && [ $TIME -lt $DUSK ]; then
	    feh --bg-scale ${DAYPAPER[1]}
	fi

	if [ $TIME -ge $DUSK ] && [ $TIME -lt $NIGHT ]; then
	    feh --bg-scale ${DUSKPAPER[1]}
	fi

	if [ $TIME -ge $NIGHT ] && [ $TIME -lt $DAWN ]; then
	    feh --bg-scale ${NIGHTPAPER[1]}
	fi


	sleep 5m
done

