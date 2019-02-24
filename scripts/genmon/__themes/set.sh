#!/bin/bash

theme=$1

echo "Set perticular theme as default."
echo "Selected theme: $theme"

if [ ! -d "$theme" ]; then
  echo "Theme not found!"
  exit 1
fi

cd "$theme/icons"

for file in $(find . -iname "volume-*.svg"); do
  f=$(echo $file | grep -E -o 'volume-([0-9]{1,2}).svg' | grep -E -o '[0-9]{1,2}')
  f="/usr/share/volumeicon/icons/Mistik/$f.png"
  echo "Processing: $file as $f"
  sudo inkscape "$file" $2 --export-png="$f"
done

killall -15 volumeicon
volumeicon &
