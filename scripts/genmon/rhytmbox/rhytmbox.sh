#!/bin/bash

# Grab default colors
# dir=$( dirname $0 )
# source "$dir/../var/define-colors.sh"

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

rhythmbox=$(wmctrl -lx | awk '{ print $3 }' | grep rhythmbox.Rhythmbox)

if [[ $rhythmbox == "" ]]; then
    echo "<img>$itheme/music-noinstance.svg</img>"
    echo "<click>rhythmbox</click>"
    exit 0
fi

time=$(rhythmbox-client --print-playing-format=%te)

echo "<tool>$(rhythmbox-client --print-playing)</tool>"

# if [[ $time == $(rhythmbox-client --print-playing-format=%te) ]]; then
if [[ $time == $(cat /tmp/genmon_rhythmbox) ]]; then
    echo "<img>$itheme/music-play.svg</img>"
    echo "<click>rhythmbox-client --play-pause</click>"
    echo "<xml><span"$sfade">$time</span></xml>"
    exit 0
else
    echo "<img>$itheme/music-pause.svg</img>"
    echo "<click>rhythmbox-client --play-pause</click>"
    echo "<xml><span"$sfade">$time</span></xml>"
    echo "${time}" > /tmp/genmon_rhythmbox
fi

