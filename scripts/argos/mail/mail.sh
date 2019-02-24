#!/usr/bin/env bash

dir=~/.scripts
source "$dir/themes/theme.sh"

messages=$(wmctrl -l | grep " — Yandex.Mail" | awk '{ print $4 }')
regex='^[0-9]+$'

#image=$(getCacheImage $itheme/blinkstick-$state.svg)

if [[ $messages =~ $regex ]]; then
  image=$(getCacheImage $itheme/mail-active.svg)
  # Set blinkstick
  bs=$dir/scripts/blinkstick.sh
  $bs flash 2 "#FDCA00"
else
  image=$(getCacheImage $itheme/mail-inactive.svg)
  messages=''
fi

echo "$messages | image=$image"
echo "----"
echo "Show | bash='/home/marko/.scripts/scripts/to.sh Yandex.Mail' terminal=false"
