#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# cut xterm from the chain of arguments because startx is stupid
option=${@/xterm/}

[[ $# -eq 0 ]] && ssh-agent bspwm

case $option in
    xfce|xfwm) exec xfwm4 & termite;;
    *        ) exec $option;;
esac

