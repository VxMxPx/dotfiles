#!/bin/bash

wal -i $(xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image)

$(dirname $0)/_conky.sh
# $(dirname $0)/_xfwm.sh

killall -9 polybar
(polybar default &)
