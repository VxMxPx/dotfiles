#!/bin/bash

# Find window by name and focus it, or go to desktop N

if [[ $1 =~ ^-?[1-9]$ ]]; then
	num=$(( $1 - 1 ));
	if [ $1 -gt `xdotool get_num_desktops` ]; then
		xdotool set_num_desktops $1;
	fi
	xdotool set_desktop $num;
else
    line=-${2:-1}
    name=$(xdotool search --name $1 | tail $line)

    if [ "x$name" != "x" ]
    then
         xdotool windowactivate "$name";
    fi
fi
