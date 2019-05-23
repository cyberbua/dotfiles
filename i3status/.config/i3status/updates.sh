#!/bin/bash

while pgrep sway; do
    echo -n "$(checkupdates | wc -l)000" > $HOME/.config/i3status/updates
    sleep 4h
done
