#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

# CPU Usage Sum
sum=$(ps aux | awk 'BEGIN { sum = 0 }  { sum += $3 }; END { print sum }')

# Check if is critical
# critical=$(echo $sum'>400' | bc -l)

# Calculate divided sum
# sum=$(echo "scale=2;"$sum"/8" | bc -l)
sum=$(echo "$sum/8" | bc)

# Check if if was critical and set color in such case
# if [[ "x$critical" == "x1" ]]; then
#   sdefault=$spanic
# fi

# Finally output
# echo "<xml><span"$sfade">C </span><span"$sdefault">"$sum"%</span></xml>"

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

echo "<img>$itheme/cpu-$state.svg</img>"
echo "<tool>CPU: $sum%</tool>"
