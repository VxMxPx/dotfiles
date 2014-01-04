#!/bin/bash

# Toggle XFCE4 bottom panel
window=$(wmctrl -lG | grep -E "1029 1680 21[\ 0-9A-Za-z\-]*xfce4-panel")
regex="^(0x[0-9a-f]+) .*$"
[[ $window =~ $regex ]]
id=${BASH_REMATCH[1]}

INFO=$(xwininfo -id $id)
STATE=$(echo "$INFO" | grep "Map State:" | head -n1 | awk -F: '{print $2}' | xargs)
WID=$(echo "$INFO" | grep "Window id:" | head -n1 | awk -F: '{print $3}' | awk '{print $1}')
if test "$STATE" = "IsViewable"; then
  xdotool windowminimize "$WID"
else
  xdotool windowmap "$WID"
fi
