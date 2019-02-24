#!/usr/bin/env bash

dir=~/.scripts
source "$dir/themes/theme.sh"

free=$(free -h | grep "Mem:" | awk '{ print $3 }')
freeraw=$(echo $free | grep -o '[0-9]*\.[0-9]*')
freeraw=$(echo "$freeraw / 1" | bc)
state=0

if   (( freeraw > 30 )); then state=11;
elif (( freeraw > 27 )); then state=10;
elif (( freeraw > 24 )); then state=9;
elif (( freeraw > 21 )); then state=8;
elif (( freeraw > 18 )); then state=7;
elif (( freeraw > 15 )); then state=6;
elif (( freeraw > 12 )); then state=5;
elif (( freeraw > 9 ));  then state=4;
elif (( freeraw > 6 ));  then state=3;
elif (( freeraw > 3 ));  then state=1;
fi

echo " | image=$(getCacheImage $itheme/ram-$state.svg)"
echo "-----"
echo "Ram usage: $free | bash='gnome-system-monitor' terminal=false"
