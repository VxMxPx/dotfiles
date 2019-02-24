#!/bin/bash

# Display message after particular amount of time.
# Example: ./beep.sh 2min The Tea is Ready!
# Example: ./beep off (kill all timers)

timeout=$1
message=$2
regex="([0-9]+)+(m(in)?|s(ec)?)"

if [[ $timeout == "off" ]]; then
    killall -9 buzz.sh
    exit 0
fi

[[ $timeout =~ $regex ]]
timeout=${BASH_REMATCH[1]}
unit=${BASH_REMATCH[2]}

if [[ ${unit:0:1} == "m" ]]; then
    timeout=$(( $timeout * 60 ))
fi

sleep $timeout

[[ "x$message" != "x" ]] && notify-send -i ~/.resources/scripts/self/beep/info.svg "Alert" "$message"
mplayer $(dirname $0)/beep.mp3
