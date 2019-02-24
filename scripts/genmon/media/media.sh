#!/bin/bash

# Grab default colors
# dir=$( dirname $0 )
# source "$dir/../var/define-colors.sh"

dir=$( dirname $0 )
source "$dir/../../themes/theme.sh"

function setstatus() {
  id=$1
  player=$(wmctrl -lx | awk '{ print $3 }' | grep $id.)

  if [[ $player == "" ]]; then
    return 1
  else
    command="qdbus org.mpris.MediaPlayer2.${id} /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player"
    time=$($command.Position)
    time=$(echo "$time/1000000" | bc)
    title=$($command.Metadata | grep 'xesam:title' | awk -F ': ' '{ print $2 }')
    if (( $time > 3600 )); then
      time=$(date -u +%k:%M:%S -d "@$time")
    else
      time=$(date -u +%M:%S -d "@$time")
    fi
    status=$($command.PlaybackStatus)
    if [[ $status == "Playing" ]]; then
      echo "<img>$itheme/music-pause.svg</img>"
      echo "<click>$command.Pause</click>"
      echo "<xml><span"$sfade">$time ($id)</span></xml>"
      echo "<tool>$title</tool>"
      return 0
    else
      echo "<img>$itheme/music-play.svg</img>"
      echo "<click>$command.Play</click>"
      echo "<xml><span"$sfade">$time ($id)</span></xml>"
      echo "<tool>$title</tool>"
      return 0
    fi
  fi
}

( setstatus "rhythmbox" ) ||
( setstatus "bomi" ) ||
( setstatus "juk" ) ||
( setstatus "smplayer" ) ||
echo "<img>$itheme/music-noinstance.svg</img><tool>Open music player</tool><click>rhythmbox</click>";

exit 0
