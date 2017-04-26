#!/bin/bash

# exit script on first error
set -o errexit

# change to this scripts directory
cd "$(dirname "$0")" || exit 1

# delete named pipe when script is terminated
trap "rm -f $1.pipe" EXIT INT TERM

# create pipe if it doesn't exist
if [[ ! -p $1.pipe ]]; then
    mkfifo "$1.pipe"
fi

# read named pipe
while [[ -p $1.pipe ]]; do
    if read line < "$1.pipe"; then
        [[ -n "$line" ]] && echo "$line"
    fi
done &


if [ -n "$2" ]; then
    # run the script periodically
    while [[ -p $1.pipe ]]; do
        ./$1
        sleep "$2"
    done
else
    wait
fi
