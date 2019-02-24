#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

# Set cookie file
cookiefile=/tmp/network-signal-cookies
domain=http://192.168.1.1

# Make initial request
curl -c "$cookiefile" "$domain/html/home.html" >  /dev/null

# Make sestatus request
status=$(curl -b "$cookiefile" "$domain/api/monitoring/status" | grep "<SignalIcon>" | grep -Po "\d+")

# cleanup
[ -f "$cookiefile" ] && rm $cookiefile

echo "<tool>Mobitel: $status</tool>"
echo "<img>$itheme/signal-$status.svg</img>"
