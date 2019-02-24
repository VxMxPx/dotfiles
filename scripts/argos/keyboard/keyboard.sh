#!/usr/bin/env bash

dir=~/.scripts
source "$dir/themes/theme.sh"

status=$(xkblayout-state print %s)

echo "| image=$(getCacheImage $itheme/xkb-$status.svg)"
echo "----"
echo "Default | image=$(getCacheImage $itheme/xkb-us.svg) bash='setxkbmap us' terminal=false"
echo "Slovene | image=$(getCacheImage $itheme/xkb-si.svg) bash='setxkbmap si' terminal=false"
echo "Russian | image=$(getCacheImage $itheme/xkb-ru.svg) bash='setxkbmap ru' terminal=false"

exit 0
