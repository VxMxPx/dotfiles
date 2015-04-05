#!/bin/bash

desktop=$(xdotool get_desktop)
desktop=$(($desktop + 1))

echo "<txt>W: "$desktop"/"$(xdotool get_num_desktops)"</txt>"
