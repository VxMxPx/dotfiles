#!/usr/bin/env bash

dir=~/.scripts
source "$dir/themes/theme.sh"

status=$(yandex-disk status | sed -n 's/Synchronization core status: \([a-z0-9]*\)/\1/p')
click='nautilus /home/marko/Downloads/Yandex.Disk/'
image=$(getCacheImage $itheme/yandex-disk-$status.svg)

if [[ $status == "busy" ]]; then
  progressraw=$(yandex-disk status | grep "Sync progress:")
  progress=$(echo $progressraw | awk '{ print $7$8 }')
  progress=${progress:1:-1}
else
  progress=''
fi

echo "$progress | image=$image"
echo "----"
echo "Open | bash='$click' terminal=false"
echo "----"
echo "Start | bash='yandex-disk start' terminal=false"
echo "Stop  | bash='yandex-disk stop' terminal=false"
echo "Sync  | bash='yandex-disk sync' terminal=false"

exit 0
