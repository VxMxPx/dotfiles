#!/bin/bash

# Fetch and set Yandex daily wallpaper.
# Meant to continuously run.
# NOTE: The Yandex daily wallpaper service is not available anymore!
#       Hence this script is broken.

# Settings
pic_dir="~/Pictures/Yandex.Wallpapers"
tmp="/tmp/yandexwallpaper"
size="2560x1440"
service="https://yandex.com/images/today?size=$size"
interval="1h"

echo "Started, I'll write wallpapers to $pic_dir and temp to $tmp"

# Pause for wifi to init
if [[ $1 != '-f' ]]; then
  sleep 20
fi

date=$(date --iso-8601)

# Perhaps picture already exits though...
if [ -f "$pic_dir/$date.jpg" ]; then
  last_date=$date
  last_hash=$(md5sum "$pic_dir/$date.jpg" | awk '{ print $1 }')
  echo "Picture already exists for $last_date, hash $last_hash"
else
  last_date="NULL"
  last_hash="NULL"
  echo "Picture not found, a fresh start"
fi

# Set current wallpaper with FEH (OPENBOX)
#pic_path=$pic_dir/$date.jpg
#pic_cropped=$pic_dir/$date-cropped.jpg
#feh --bg-fill ${pic_cropped}

# Start infinite loop
while true; do
  date=$(date --iso-8601)
  echo "Checked $date"
  if [[ $last_date != $date || $1 == '-f'  ]]; then
    echo "A new date, today is $date, I'll grab a fresh image..."
    last_date=$date
    curl $service > $tmp
    hash=$(md5sum $tmp | awk '{ print $1 }')
    if [[ $last_hash != $hash || $1 == '-f' ]]; then

      echo "Image is different and it will be set as a background..."

      last_hash=$hash
      pic_path=$pic_dir/$date.jpg
      pic_cropped=$pic_dir/$date-cropped.jpg
      cp $tmp $pic_path

      # produce cropped version without watermark
      # XFCE
      #convert $pic_path -background "#303030" -splice 0x28 -crop 0x0+0-28 $pic_cropped
      # GNOME
      convert $pic_path -crop 0x0+0-28 $pic_cropped

      # update description
      describe=$(curl https://yandex.com/images/ | grep -oP "b-501px__description(.*)</p" | cut -d '>' -f2 | cut -d '<' -f1)
      echo $describe
      # XFCE
      #convert $pic_cropped -pointsize 12 -font Ubuntu -background '#0008' -fill '#fff' label:"$describe" -gravity southWest -geometry +5+5 -composite $pic_cropped
      # GNOME
      convert $pic_cropped -pointsize 12 -font Ubuntu -background '#0008' -fill '#fff' label:"$describe" -gravity southWest -geometry +32+5 -composite $pic_cropped

      # set wallpaper
      # ./apply-wallpaper.sh $pic_cropped
      # KDE
      #qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "file://'$pic_cropped'")}'
      # XFCE
      #xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set $pic_cropped
      # GNOME
      gsettings set org.gnome.desktop.background picture-uri file://${pic_cropped}
      gsettings set org.gnome.desktop.screensaver picture-uri file://${pic_cropped}
      # OPENBOX
      #feh --bg-fill ${pic_cropped}
      # BROWSER HOME PAGE
      # cp ${pic_cropped} ~/Projects/startpage/wallpaper.jpg
    else
      echo "Image has the same hash as previous ($hash), nothing to do..."
      last_date="$last_date-x"
      echo "I'll make last date dirty: $last_date"
    fi
  fi
  echo "I'm going to sleep for $interval"
  sleep $interval
done
