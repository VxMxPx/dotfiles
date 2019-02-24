#!/usr/bin/env bash

dir=~/.scripts
source "$dir/themes/theme.sh"

state=1

# Ping Line
ping=$(ping -c 8 -W 2 -q 8.8.8.8)
received=$( echo -e "$ping" | grep 'packets transmitted' | awk '{ print $4 }' )
timeof=$( echo -e "$ping" | grep /avg/ | awk '{ print $4 }' | awk -F '/' '{ print $2 }' )

timeofround=$(echo "$timeof/1" | bc)

# Check if we have time
if [[ "x$timeof" == "x" ]]; then
    timeof='N/A'
    state=5
else
  if [[ $received -lt 3 ]]; then
      state=4
  elif [[ $received -lt 6 ]]; then
      state=3
  else
    if   (( timeofround > 200 )); then state=4;
    elif (( timeofround > 150 )); then state=3;
    elif (( timeofround > 100 )); then state=2;
    fi
  fi
fi

# Finally output
echo "| image=$(getCacheImage $itheme/ping-$state.svg)"
echo "----"
echo "${timeof}ms | bash='gnome-system-monitor' terminal=false"
