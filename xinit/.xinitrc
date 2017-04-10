#!/bin/bash

#####################
# global X settings #
#####################
export PATH="$HOME/scripts:$PATH"
export QT_QPA_PLATFORMTHEME='gtk2'
setxkbmap -option 'caps:ctrl_modifier'   # caps = ctrl
xcape -e 'Caps_Lock=Escape'              # ctrl = esc when tapped on its own
xset r rate 200 30                       # key auto-repeat
#####################

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# cut xterm from the chain of arguments because startx is stupid
option=${@/xterm/}

[[ $# -eq 0 ]] && ssh-agent i3

case $option in
    i3|i3wm)  ssh-agent i3;;
    bspwm)    ssh-agent bspwm;;
    xfce|xfwm)  exec xfwm4 & termite;;
    *        )  exec $option;;
esac

