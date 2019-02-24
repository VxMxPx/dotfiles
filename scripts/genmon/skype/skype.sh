#!/bin/bash

# Grab theme
dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

skype=$(wmctrl -l | grep Skype™)

# if [[ $(wmctrl -l | grep Skype™) ]]; then echo "Ellow"; else echo "Noooo"; fi

if [[ $skype ]]; then

    messages=$(echo $skype | awk '{ print $4 }' | grep -o '\[[0-9]*\]')

    if [[ "x$messages" == "x" ]]; then
        #    messages=0
        echo "<img>/$theme/skype-icon-inactive.png</img>"
    else
        echo "<img>/$theme/skype-icon.png</img>"
    fi

    echo "<click>/home/marko/.scripts/scripts/to.sh Skype™</click>"
    # echo "<txt> "$messages"</txt>"
else
    echo "<img>/$theme/skype-icon-missing.png</img>"
fi
