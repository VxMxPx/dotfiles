#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

updates=$(checkupdates | wc -l)

if (( $updates > 0  )); then
    echo "<img>$itheme/update-active.svg</img>"
    echo "<txt>$updates </txt>"
else
    echo "<img>$itheme/update-inactive.svg</img>"
fi

echo "<click>xterm -e 'yaourt -Syua; sudo paccache -r; sudo paccache -ruk0'</click>"
