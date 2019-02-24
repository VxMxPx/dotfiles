#!/usr/bin/env bash

dir=~/.scripts
source "$dir/themes/theme.sh"

state=$(${dir}/scripts/blinkstick.sh status)

echo "| image=$(getCacheImage $itheme/blinkstick-$state.svg)"
echo "----"
echo "Toggle | bash='$dir/scripts/blinkstick.sh toggle' terminal=false"
