#!/bin/bash

# Grab default colors
dir=$( dirname $0 )
source "$dir/../var/define-colors.sh"

home_hdd=$(sudo /usr/sbin/smartctl -a /dev/sdb | grep -i temperature | awk '{ print $10 }')
server_hdd=$(ssh marko@192.168.1.188 sudo /usr/sbin/smartctl -a -d sat /dev/sda | grep -i temperature | awk '{ print $10 }')
server_cpu=$(ssh marko@192.168.1.188 sudo vcgencmd measure_temp | grep -o '[0-9.]*')

echo "<xml>\
<span"$sfade">D-hdd </span>\
<span"$sdefault">"$home_hdd"°</span> \
<span"$sfade">S-hdd </span>\
<span"$sdefault">"$server_hdd"° </span>\
<span"$sfade">S-cpu </span>\
<span"$sdefault">"$server_cpu"°</span>\
</xml>"
