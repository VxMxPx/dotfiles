#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

state=$(${dir}/../../scripts/blinkstick.sh status)

echo "<img>$itheme/blinkstick-$state.svg</img>"
echo "<click>$dir/../../scripts/blinkstick.sh toggle</click>"
