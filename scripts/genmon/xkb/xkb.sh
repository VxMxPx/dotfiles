#!/bin/bash

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

layout=$(xkblayout-state print "%s")
layout_fullname=$(xkblayout-state print "%n")

echo "<click>xkblayout-state set +1</click>"
echo "<img>$itheme/xkb-$layout.svg</img>"
echo "<tool>$layout_fullname</tool>"
# echo "<xml><span"$sdefault">"$layout"</span></xml>"
