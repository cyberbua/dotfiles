#/bin/bash

if [ -v $1 ] || [ -v $2 ] || [ -v $3 ]; then
	echo "usage: wallpaper.sh [latitude] [longitude] [wallpaper path]"
	echo 
	echo "latitude/longigude are expressed in floating-point degrees, with [NESW] appended"
	echo 
	echo "the wallpaer directory has to contain image files with this name structure:"
	echo "[name][dawn|day|dusk|night].[jpg|png]"
	echo "example:" 	
	echo "    nowPaper"
    echo "    ├── Canyondawn.png"
    echo "    ├── Canyonday.png"
    echo "    ├── Canyondusk.png"
    echo "    └── Canyonnight.png"
	echo
	echo "command exapmle:"
	echo "    wallpaper.sh 48.20849N 16.37208E ~/wallpapers/nowPaper"
	exit 1
fi

LAT=$1
LONG=$2
WPDIR=$3


DAWN=$(./sunwait -p $LAT $LONG | grep "Civil twilight starts" |grep -Eo '[0-9]{1,4}' | head -n1)
DAY=$(./sunwait -p $LAT $LONG | grep "Sun rises" |grep -Eo '[0-9]{1,4}' | head -n1)
DUSK=$(./sunwait -p $LAT $LONG | grep "Sun rises" |grep -Eo '[0-9]{1,4}' | tail -n1)
NIGHT=$(./sunwait -p $LAT $LONG | grep "Civil twilight starts" |grep -Eo '[0-9]{1,4}' | tail -n1)
TIME=$(date +"%H%M")

# echo $DAWN $DAY $DUSK $NIGHT

DAWNPAPER=($WPDIR/*dawn*)
DAYPAPER=($WPDIR/*day*)
DUSKPAPER=($WPDIR/*dusk*)
NIGHTPAPER=($WPDIR/*night*)


if [ $TIME -ge $DAWN -a $TIME -lt $DAY ]; then
	feh --bg-scale ${DAWNPAPER[1]}
fi

if [ $TIME -ge $DAY -a $TIME -lt $DUSK ]; then
    feh --bg-scale ${DAYPAPER[1]}
fi

if [ $TIME -ge $DUSK -a $TIME -lt $NIGHT ]; then
    feh --bg-scale ${DUSKPAPER[1]}
fi

if [ $TIME -ge $NIGHT -o $TIME -lt $DAWN ]; then
	feh --bg-scale ${NIGHTPAPER[1]}
fi




#while :
#do
#	./sunwait -v sun up -0:30:00 48.2084900N 16.3720800E
#	feh --bg-scale ~/wallpapers/nowPaper/SanDiegodawn.png
#
#	./sunwait -v sun up +0:45:00 48.2084900N 16.3720800E
#	feh --bg-scale ~/wallpapers/nowPaper/SanDiegoday.png
#
#	./sunwait -v sun down -0:45:00 48.2084900N 16.3720800E
#	feh --bg-scale ~/wallpapers/nowPaper/SanDiegodusk.png
#
#	./sunwait -v sun down +0:30:00 48.2084900N 16.3720800E
#	feh --bg-scale ~/wallpapers/nowPaper/SanDiegonight.png
#done
