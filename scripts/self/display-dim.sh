#!/bin/bash

# Will dim the secondary display
# Example: ./display-dim.sh on | ./display-dim.sh off

EXT="HDMI-0"
declare -i CURRENT
CURRENT=$(xrandr --verbose | grep "Brightness:" | tail -n 1 | cut -f2 -d ".")
CURRENT=$(( $CURRENT / 10 ))

if [[ $CURRENT < 1 ]]; then
    CURRENT=9
fi

if [[ $1 == "on" ]]; then
    for (( i=$CURRENT; i>=1; i-- )); do
        xrandr --output $EXT --brightness "0.$i"
    done
else
    for (( i=$CURRENT; i<=9; i++ )); do
        xrandr --output $EXT --brightness "0.$i"
    done
fi
