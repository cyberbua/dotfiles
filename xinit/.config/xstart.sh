xsetroot -cursor_name left_ptr           # set the default mouse cursor
feh --bg-scale ~/.config/wallpaper       # set the wallpaper
nm-applet &
compton -b
redshift -l 16:48 -t 6500:4500 &
polybar top &
xfce4-power-manager
/usr/bin/start-pulseaudio-x11 &
xautolock -locker blurlock -time 3 -corners 0-00 &
xset s off -dpms                         # disbale screen blanking (already handled by blurlock)
xhost +local:                            # allow local containers to access X
