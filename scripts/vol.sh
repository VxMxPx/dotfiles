#!/bin/bash

# Description: Change volume.
# Command: ^vol([0-9]+|\<|\>|\?)?$
# Examples: vol,vol>,vol<,vol50,vol?

# function showVolumeLevel {
#     # Front Right: Playback 22 [71%] [-13.50dB] [on]
#     regex=" \[([0-9]+\%)\] "
#     volume=$(amixer get Master | tail -1)
#     [[ $volume =~ $regex ]]
#     notify-send -i speaker "Volume: ${BASH_REMATCH[1]}"
# }

function getVolumeLevel {
    # Front Right: Playback 22 [71%] [-13.50dB] [on]
    regex=" \[([0-9]+)\%\] "
    volume=$(amixer get Master | tail -1)
    [[ $volume =~ $regex ]]
    volume=${BASH_REMATCH[1]}
}

if [[ "x$1" == "x" ]]; then
    # No parameters: vol - Toggle master on/off
    # amixer -q set Master toggle # XFCE4
    # KDE Way...
    qdbus-qt4 org.kde.kmix /kmix/KMixWindow/actions/mute org.qtproject.Qt.QAction.trigger
elif [[ ${1:0:1} == ">" ]];
then
    # > 10% More
    # amixer -q set Master 10%+; # XFCE4
    # KDE Way...
    count=$(echo $1 | grep -o ">" | wc -l)
    for (( c=1; c<=$count; c++ ))
    do
        qdbus-qt4 org.kde.kmix /kmix/KMixWindow/actions/increase_volume org.qtproject.Qt.QAction.trigger
    done
elif [[ ${1:0:1} == "<" ]];
then
    # 10% Less
    # amixer -q set Master 10%-; # XFCE4 Way
    # KDE Way...
    count=$(echo $1 | grep -o "<" | wc -l)
    for (( c=1; c<=$count; c++ ))
    do
        qdbus-qt4 org.kde.kmix /kmix/KMixWindow/actions/decrease_volume org.qtproject.Qt.QAction.trigger
    done
elif [[ "$1" == "?" ]];
then
    qdbus-qt4 org.kde.kmix /kmix/KMixWindow/actions/increase_volume org.qtproject.Qt.QAction.trigger
    qdbus-qt4 org.kde.kmix /kmix/KMixWindow/actions/decrease_volume org.qtproject.Qt.QAction.trigger
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
    qdbus-qt4 org.kde.kmix /kmix/KMixWindow/actions/increase_volume org.qtproject.Qt.QAction.trigger
    qdbus-qt4 org.kde.kmix /kmix/KMixWindow/actions/decrease_volume org.qtproject.Qt.QAction.trigger
fi
