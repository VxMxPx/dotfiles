#!/bin/bash

# Description: Change volume.
# Command: ^vol([0-9]+|\<|\>|\?)?$
# Examples: vol,vol>,vol<,vol50,vol?
# Need: extra/alsa-utils

function showVolumeLevel {
    # Front Right: Playback 22 [71%] [-13.50dB] [on]
    regex=" \[([0-9]+\%)\] "
    volume=$(amixer get Master | tail -1)
    [[ $volume =~ $regex ]]
    notify-send -i speaker "Volume: ${BASH_REMATCH[1]}"
}

function getVolumeLevel {
    # Front Right: Playback 22 [71%] [-13.50dB] [on]
    regex=" \[([0-9]+)\%\] "
    volume=$(amixer get Master | tail -1)
    [[ $volume =~ $regex ]]
    volume=${BASH_REMATCH[1]}
}

if [[ "x$1" == "x" ]]; then
    # No parameters: vol - Toggle master on/off
    amixer -q set Master toggle # XFCE4
elif [[ ${1:0:1} == ">" ]];
then
    # > 10% More
    amixer -q set Master 10%+; # XFCE4
elif [[ ${1:0:1} == "<" ]];
then
    # 10% Less
    # XFCE4 Way
    amixer -q set Master 10%-
else
    new=$1
    # Costume volume 0-100
    if [ $new -gt 100 ]; then
        notify-send "Too high volume!"
        exit 1
    fi

    # We can't make too big step either!
    getVolumeLevel
    if [[ $new -gt $(( $volume + 20 )) ]]; then
        new=$(( $volume + 20 ))
    fi

    amixer -q set Master $new%
fi

showVolumeLevel
