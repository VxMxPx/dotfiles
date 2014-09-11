#!/bin/bash

# Close number of desktops, if number is provided as first parameter.
# Example: close 1 -- close one desktop
if [[ $1 =~ ^-?[1-9]$ ]]; then
    limit=$(( `xdotool get_num_desktops` - $1 ));
    if [ $limit -lt 1 ]; then
        exit 0;
    fi
    xdotool set_num_desktops $limit;
    exit 0;
fi

# Wait fot app-finder to actually close
while [[ $(xdotool getactivewindow getwindowname | grep -E "Application Finder") ]]; do
    sleep 0.1
done

# Close partulcar window, but don't close desktop
active=$(xdotool getactivewindow);
title=$(xdotool getwindowname $active);
if [[ "x$title" != "xDesktop" && "x$title" != "xplasma-desktop" ]]; then
    wmctrl -c :ACTIVE:
fi
