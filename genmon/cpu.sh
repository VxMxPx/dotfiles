#!/bin/bash

sum=$(ps aux | awk 'BEGIN { sum = 0 }  { sum += $3 }; END { print sum }')
critical=$(echo $sum'>200' | bc -l)
out=$(echo "scale=2;"$sum"/4" | bc -l)

if [[ "x$critical" == "x1" ]]; then
	out="!!"$out
fi

echo "<txt>C: "$out"%</txt>"
