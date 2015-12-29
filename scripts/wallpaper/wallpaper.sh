#!/usr/bin/env bash

# TODO:
# improve option handling (allow -ov)
# improve dawn/day/dusk/night timings
# check for dependencies either in $PATH or current directory
# cicle through wallpaper sets


# Define global variables
VERSION="0.9"
let LASTRUN=DAWN=DAY=DUSK=NIGHT=0
VERBOSE=false
ONESHOT=false

function printHelp() {
	echo -e "$(basename $0) v$VERSION, sets wallpapers depending on daytime"
	echo -e "Usage: $(basename $0) [latitude] [longitude] [wallpaper path]\n"
	echo -e "This script requires 'feh' for setting the wallpaper and 'sunwait' to calculate sunrise/set."
	echo -e "They can either be somewhere in your \$PATH or in the same directory as this script.\n"
	echo -e "latitude/longigude are expressed in floating-point degrees, with [NESW] appended\n"
	echo -e "The wallpaper directory has to contain image sets with this name structure:"
	echo -e "[name][dawn|day|dusk|night]"
	echo -e "example set:"
	echo -e " \tnowPaper/"
	echo -e " \t├── Canyondawn.png"
	echo -e " \t├── Canyonday.png"
	echo -e " \t├── Canyondusk.png"
	echo -e " \t└── Canyonnight.png"
	echo -e "If you have multiple sets of wallpapers in this directory it will cicle trough them daily\n"
	echo -e "Options:"
	echo -e " -h \tPrint help (this screen)^"
	# echo -e " -i \tIntervall in minutes to check if new wallpaper has to be set (D=5)"
	echo -e " -o \tOne Shot mode (set wallpaper and exit)"
	echo -e " -v \tVerbose Mode"
	echo -e "\nCommand exapmle:"
	echo -e "\t$(basename $0) 48.20849N 16.37208E ~/wallpapers/nowPaper"
}

function getTimes() {
	LASTRUN=$(date +%F)
	DAWN=$(./sunwait -p $LAT $LONG | grep "Civil twilight starts" | grep -Eo '[0-9]{1,4}' | head -n1)
	DAY=$(./sunwait -p $LAT $LONG | grep "Sun rises" | grep -Eo '[0-9]{1,4}' | head -n1)
	DUSK=$(./sunwait -p $LAT $LONG | grep "Sun rises" | grep -Eo '[0-9]{1,4}' | tail -n1)
	NIGHT=$(./sunwait -p $LAT $LONG | grep "Civil twilight starts" | grep -Eo '[0-9]{1,4}' | tail -n1)
}

# parse options
while [[ $# > 3 ]]; do
    case $1 in
        -h)
            printHelp
			exit 0
            ;;
        -o)
            ONESHOT=true
            ;;
        -v)
            VERBOSE=true
            ;;
        -*)
            echo -e "unknown option\n"
			printHelp
			exit 1
            ;;
        *)
            echo -e "too many arguments!\n"
			printHelp
			exit 1
    esac
    shift
done

# cry out loud if not enough arguments
if [ $# -lt 3 ]; then
	echo -e "not enough arguments!\n"
	printHelp
	exit 1
fi

LAT=$1
LONG=$2
WPDIR=$3

while true; do
	# determine daytimes if not allready done today
	if [ "$LASTRUN" != "$(date +%F)" ]; then
		getTimes
		[ $VERBOSE = true ] && echo "Dawn: $DAWN; Day: $DAY; Dusk: $DUSK; Night: $NIGHT"
	fi

	# fill the wallpaper arrays
	DAWNPAPER=($WPDIR/*dawn*)
	DAYPAPER=($WPDIR/*day*)
	DUSKPAPER=($WPDIR/*dusk*)
	NIGHTPAPER=($WPDIR/*night*)

	# decide which wallpaper set to use
	PAPERSET=$RANDOM%${#DAWNPAPER[@]}

	TIME=$(date +%H%M)

	# set the wallpaper
	if [ $TIME -ge $DAWN ] && [ $TIME -lt $DAY ]; then
	    feh --bg-scale ${DAWNPAPER[$PAPERSET]}
		[ $VERBOSE = true ] && echo "Time: $TIME; WP: ${DAWNPAPER[$PAPERSET]}"
	fi

	if [ $TIME -ge $DAY ] && [ $TIME -lt $DUSK ]; then
	    feh --bg-scale ${DAYPAPER[$PAPERSET]}
		[ $VERBOSE = true ] && echo "Time: $TIME; WP: ${DAYPAPER[$PAPERSET]}"
	fi

	if [ $TIME -ge $DUSK ] && [ $TIME -lt $NIGHT ]; then
	    feh --bg-scale ${DUSKPAPER[$PAPERSET]}
		[ $VERBOSE = true ] && echo "Time: $TIME; WP: ${DUSKPAPER[$PAPERSET]}"
	fi

	if [ $TIME -ge $NIGHT ] || [ $TIME -lt $DAWN ]; then
	    feh --bg-scale ${NIGHTPAPER[$PAPERSET]}
		[ $VERBOSE = true ] && echo "Time: $TIME; WP: ${NIGHTPAPER[$PAPERSET]}"
	fi

	# exit here if -o is used
	[ $ONESHOT = true ] && exit 0

	sleep 5m
done
