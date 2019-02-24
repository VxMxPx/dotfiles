#!/bin/bash

# Grab default colors
dir=$( dirname $0 )
source "$dir/../var/define-colors.sh"

# Ping Line
ping=$(ping -c 8 -W 2 -q 5.255.255.5)
received=$( echo -e "$ping" | grep 'packets transmitted' | awk '{ print $4 }' )
timeof=$( echo -e "$ping" | grep /avg/ | awk '{ print $4 }' | awk -F '/' '{ print $2 }' )

# Check if we have time
if [[ "x$timeof" == "x" ]]; then
    timeof='N/A'
fi

# Set color
if [[ $received -lt 3 ]]; then
    scolor=$spanic
elif [[ $received -lt 6 ]]; then
    scolor=$swarning
else
    scolor=$sdefault
fi

# To file
#date=$(date "+%F %T")
#echo "$date -> $timeof" >> /home/marko/Documents/ping-report.txt

# Finally output
echo "<xml><span"$sfade">P </span><span"$scolor">"$timeof"ms</span></xml>"
