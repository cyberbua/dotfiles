#!/bin/bash

while pgrep -x sway; do
    UPDATES=$(checkupdates | wc -l)
    if [ $UPDATES -eq 0 ]; then
        rm $HOME/.config/i3status/updates
    else
        echo $UPDATES > $HOME/.config/i3status/updates
    fi

    sleep 3h
done
