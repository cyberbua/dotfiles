setxkbmap -option 'caps:ctrl_modifier'   # caps = ctrl
xcape -e 'Caps_Lock=Escape'              # ctrl = esc when tapped on its own
xsetroot -cursor_name left_ptr           # set the default mouse cursor
xmodmap -e "keycode 135 = Multi_key"
feh --bg-scale ~/.config/bspwm/wallpaper # set the wallpaper
nm-applet &
compton -b
redshift -l 16:48 -t 6500:4500 &
xfsettingsd &
polybar top &
xfce4-power-manager
/usr/bin/start-pulseaudio-x11 &
xautolock -locker blurlock -time 3 -corners 0-00 &
xset s off -dpms                         # disbale screen blanking (already handled by blurlock)
export QT_STYLE_OVERRIDE=GTK+            # use GTK theme for Qt-Apps
xhost +local:                            # allow local containers to access X
xset r rate 200 30                       # key auto-repeat   # key auto-repeat
