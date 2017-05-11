#!/bin/bash

# exit script on first error
set -o errexit

# change to this scripts directory
cd "$(dirname "$0")" || exit 1

# set pipe name
PIPE=$1.pipe.$$

# delete named pipe when script is terminated
trap "rm -f $PIPE" EXIT INT TERM

# create pipe if it doesn't exist
if [[ ! -p $PIPE ]]; then
    mkfifo "$PIPE"
else
    exit 1
fi

# read named pipe
while [[ -p $PIPE ]]; do
    if read line < "$PIPE"; then
        [[ -n "$line" ]] && echo "$line"
    fi
done &


if [ -n "$2" ]; then
    # run the script periodically
    while [[ -p $PIPE ]]; do
        ./$1
        sleep "$2"
    done
else
    wait
fi
