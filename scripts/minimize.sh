#!/bin/bash

# Wait fot app-finder to actually close
while [[ $(xdotool getactivewindow getwindowname | grep -E "Application Finder") ]]; do
    sleep 0.1
done

# Toggle minimize state
active=$(xdotool getactivewindow);
title=$(xdotool getwindowname $active);
if [ "x$title" != "xDesktop" ]; then
 	xdotool windowminimize $active;
fi
