#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

bps=$(awk '/enp3s0/ {i++; rx[i]=$2}; END{print rx[2]-rx[1]}' <(cat /proc/net/dev; sleep 2; cat /proc/net/dev))
bps=$(echo "($bps*8)/2" | bc)
bps_cute=$(printf %s $bps | numfmt --to=iec-i --format='%6.2f')
state=0

  if (( bps > 10000000 )); then state=10;
elif (( bps > 9000000 ));  then state=9;
elif (( bps > 8000000 ));  then state=8;
elif (( bps > 7000000 ));  then state=7;
elif (( bps > 6000000 ));  then state=6;
elif (( bps > 5000000 ));  then state=5;
elif (( bps > 4000000 ));  then state=4;
elif (( bps > 3000000 ));  then state=3;
elif (( bps > 2000000 ));  then state=2;
elif (( bps > 1000000 ));  then state=1;
fi

echo "<tool>Download: $bps_cute</tool>"
echo "<img>$itheme/nt-down-$state.svg</img>"
echo "<txt> $bps_cute</txt>"
