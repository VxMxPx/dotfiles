#!/bin/bash

# Will turn on/off the secondary display
# Example: ./display-toggle.sh on | ./display-toggle.sh off

EXT="HDMI-0"
IN="DVI-I-2"

if [[ $1 == "on" ]]; then
    xrandr --output $IN --auto --primary --output $EXT --auto --right-of $IN
else
    xrandr --output $IN --auto --output $EXT --off
fi
