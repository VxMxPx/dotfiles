#!/bin/bash

# Grab theme
dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

skype=$(wmctrl -l | grep "Skype for Linux Alpha");

# if [[ $(wmctrl -l | grep Skype™) ]]; then echo "Ellow"; else echo "Noooo"; fi

if [[ $skype ]]; then

    messages=$(echo $skype | awk '{ print $8 }' | grep -o '\([0-9]*\)')

    if [[ "x$messages" == "x" ]]; then
        #    messages=0
        echo "<img>$itheme/skype-inactive.svg</img>"
    else
        echo "<img>$itheme/skype-active.svg</img>"
        # Set blinkstick
        bs=$dir/../../scripts/blinkstick.sh
        $bs flash 6 "#BFE9F9"
    fi

    echo "<click>/home/marko/.scripts/scripts/to.sh Skype</click>"
    # echo "<txt> "$messages"</txt>"
else
    echo "<img>$itheme/skype-noinstance.svg</img>"
fi
