#!/usr/bin/env bash

dir=~/.scripts
source "$dir/themes/theme.sh"

# CPU Usage Sum
sum=$(ps aux | awk 'BEGIN { sum = 0 }  { sum += $3 }; END { print sum }')

sum=$(echo "$sum/8" | bc)

state=1

if   (( sum > 95 )); then state=10;
elif (( sum > 90 )); then state=9;
elif (( sum > 80 )); then state=8;
elif (( sum > 70 )); then state=7;
elif (( sum > 60 )); then state=6;
elif (( sum > 50 )); then state=5;
elif (( sum > 40 )); then state=4;
elif (( sum > 30 )); then state=3;
elif (( sum > 20 )); then state=2;
fi

echo " | image=$(getCacheImage $itheme/cpu-$state.svg)"
echo "-----"
echo "CPU: $sum% | bash='gnome-system-monitor' terminal=false"
