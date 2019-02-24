#!/bin/bash

# Grab default colors
# dir=$( dirname $0 )
# source "$dir/define-colors.sh"

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

status=$(yandex-disk status | sed -n 's/Synchronization core status: \([a-z0-9]*\)/\1/p')

echo "<click>nautilus /home/marko/Downloads/Yandex.Disk/</click>"
echo "<img>$itheme/yandex-disk-$status.svg</img>"

if [[ $status == "busy" ]]; then
    progressraw=$(yandex-disk status | grep "Sync progress:")
    progress=$(echo $progressraw | awk '{ print $7$8 }')
    progress=${progress:1:-1}
    echo "<tool>$progressraw</tool>"
    echo "<xml><span"$sfade">$progress</span></xml>"
else
    echo "<tool>Yandex Disk: $status</tool>"
fi

exit 0
