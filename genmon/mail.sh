#!/bin/bash

messages=$(wmctrl -l | grep " — Yandex.Mail" | awk '{ print $4 }')
regex='^[0-9]+$'

if [[ $messages =~ $regex ]]; then
#    messages=0
    echo "<img>/home/marko/.scripts/genmon/mail-icon.png</img>"
else
    echo "<img>/home/marko/.scripts/genmon/mail-icon-inactive.png</img>"
fi

echo "<click>/home/marko/.scripts/scripts/to.sh Yandex.Mail</click>"
# echo "<txt> "$messages"</txt>"
