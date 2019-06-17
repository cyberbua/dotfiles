#!/bin/bash

while pgrep -x sway; do
    echo -n "$(checkupdates | wc -l)001" > $HOME/.config/i3status/updates
    sleep 4h
done
