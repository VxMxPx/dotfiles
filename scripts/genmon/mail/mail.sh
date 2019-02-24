#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

messages=$(wmctrl -l | grep " — Yandex.Mail" | awk '{ print $4 }')
regex='^[0-9]+$'

if [[ $messages =~ $regex ]]; then
#    messages=0
    echo "<img>$itheme/mail-active.svg</img>"
    # Set blinkstick
    bs=$dir/../../scripts/blinkstick.sh
    $bs flash 2 "#FDCA00"
else
    echo "<img>$itheme/mail-inactive.svg</img>"
fi

echo "<click>/home/marko/.scripts/scripts/to.sh Yandex.Mail</click>"
# echo "<txt> "$messages"</txt>"
