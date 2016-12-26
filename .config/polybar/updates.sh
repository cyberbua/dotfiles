#!/bin/bash

# change to this scripts directory
cd "$(dirname "$0")" || exit 1

if [[ -f lastupdate ]]; then
    LASTUPDATE=$(head -n1 lastupdate)
else
    LASTUPDATE=0
fi

NOW=$(date +%s)

# if last update more than 3 hours ago or "now" argument used
if (( (NOW - LASTUPDATE) > 10800 )) || [[ "$1" == "now" ]] ; then
    date +%s > lastupdate
    checkupdates | wc -l | tee -a lastupdate
else
    tail -n 1 lastupdate
fi

