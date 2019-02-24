#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

bps=$(awk '/enp3s0/ {i++; tx[i]=$10}; END{print tx[2]-tx[1]}' <(cat /proc/net/dev; sleep 2; cat /proc/net/dev))
bps=$(echo "($bps*8)/2" | bc)
bps_cute=$(printf %s $bps | numfmt --to=iec-i --format='%.2f')
state=0

  if (( bps > 3000000 ));  then state=10;
elif (( bps > 2700000 ));  then state=9;
elif (( bps > 2400000 ));  then state=8;
elif (( bps > 2100000 ));  then state=7;
elif (( bps > 1800000 ));  then state=6;
elif (( bps > 1500000 ));  then state=5;
elif (( bps > 1200000 ));  then state=4;
elif (( bps > 900000 ));   then state=3;
elif (( bps > 600000 ));   then state=2;
elif (( bps > 300000 ));   then state=1;
fi

echo "<tool>Upload: $bps_cute</tool>"
echo "<img>$itheme/nt-up-$state.svg</img>"
