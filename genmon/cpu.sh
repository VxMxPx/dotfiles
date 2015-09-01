#!/bin/bash

# Grab default colors
dir=$( dirname $0 )
source "$dir/define-colors.sh"

# CPU Usage Sum
sum=$(ps aux | awk 'BEGIN { sum = 0 }  { sum += $3 }; END { print sum }')

# Check if is critical
critical=$(echo $sum'>200' | bc -l)

# Calculate divided sum
sum=$(echo "scale=2;"$sum"/4" | bc -l)

# Check if if was critical and set color in such case
if [[ "x$critical" == "x1" ]]; then
	snormal="#ee4444"
fi

# Finally output
echo "<xml><span"$sfade">C: </span><span"$sdefault">"$sum"%</span></xml>"
