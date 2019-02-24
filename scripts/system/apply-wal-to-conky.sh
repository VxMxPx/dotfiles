#!/bin/bash
killall -9 conky
COLOR=$(head -n 1 ~/.cache/wal/colors)
convert ~/.conky/top-left.png \( -clone 0 -fill $COLOR -colorize 100% \) -composite ~/.conky/top-left-colored.png
convert ~/.conky/top-right.png \( -clone 0 -fill $COLOR -colorize 100% \) -composite ~/.conky/top-right-colored.png
(conky &)

