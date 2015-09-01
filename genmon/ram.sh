#!/bin/bash

# Grab default colors
dir=$( dirname $0 )
source "$dir/define-colors.sh"

echo "<xml>\
<span"$sfade">M: </span>\
<span"$sdefault">"$(free -h | grep "Mem:" | awk '{ print $3 }')"</span>\
</xml>"
