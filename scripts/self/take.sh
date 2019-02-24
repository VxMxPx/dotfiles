#!/bin/bash

# Find window by name and put it to the current desktop

line=${2:-1}
window_id=$(wmctrl -l | grep -i $1 | sed -n $line"p" | grep -oEi 0x[0-9a-f]+)
desktop=$(xdotool get_desktop)

if [[ $window_id != "" ]]; then
    xdotool set_desktop_for_window $window_id $desktop
fi
