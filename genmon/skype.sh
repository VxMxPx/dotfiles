#!/bin/bash

skype=$(wmctrl -l | grep Skype™);

# if [[ $(wmctrl -l | grep Skype™) ]]; then echo "Ellow"; else echo "Noooo"; fi

if [[ $skype ]]; then
    
    messages=$(echo $skype | awk '{ print $4 }' | grep -i '\[[0-9]*\]' | cut -d ] -f 1 | cut -d [ -f 2)
    
    if [[ "x$messages" == "x" ]]; then
        #    messages=0
        echo "<img>/home/marko/.scripts/genmon/skype-icon-inactive.png</img>"
    else
        echo "<img>/home/marko/.scripts/genmon/skype-icon.png</img>"
    fi

    echo "<click>/home/marko/.scripts/scripts/to.sh Skype™</click>"
    # echo "<txt> "$messages"</txt>"
else
    echo "<img>/home/marko/.scripts/genmon/skype-icon-missing.png</img>"
fi