#!/bin/bash

messages=$(wmctrl -l | grep Skype™ | awk '{ print $4 }' | grep -i '\[[0-9]*\]' | cut -d ] -f 1 | cut -d [ -f 2)

if [[ "x$messages" == "x" ]]; then
#    messages=0
    echo "<img>/home/marko/.scripts/genmon/skype-icon-inactive.png</img>"
else
    echo "<img>/home/marko/.scripts/genmon/skype-icon.png</img>"
fi

echo "<click>/home/marko/.scripts/scripts/to.sh Skype™</click>"
# echo "<txt> "$messages"</txt>"
