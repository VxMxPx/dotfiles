#!/bin/sh

notify=~/.resources/scripts/notify-send.sh/notify-send.sh
device=$1
action=$2

if [ "$device" == 'Capture' ]; then
  iconCategory='microphone-sensitivity'
else
  iconCategory='audio-volume'
fi

if [ "$action" == 'plus' ]; then
  base=$(amixer -D pulse sset $device 5%+ | grep 'Right:')
elif [ "$action" == 'minus' ]; then
  base=$(amixer -D pulse sset $device 5%- | grep 'Right:')
elif [ "$action" == 'toggle' ]; then
  base=$(amixer -D pulse sset $device toggle | grep 'Right:')
fi

state=$(echo $base | awk '{ print $6 }')
volume=$(echo $base | awk -F'[][%]' '{ print $2 }')

if [ "$state" == '[on]' ]; then
  if [ "$volume" -gt 70 ]; then
    icon="high"
  elif [ "$volume" -gt 30 ]; then
    icon="medium"
  elif [ "$volume" -gt 5 ]; then
    icon="low"
  else
    icon="muted"
  fi
else
  volume=0
  icon='muted'
fi

$notify " "\
  --replace-file=/tmp/volumenotification \
  -i $iconCategory-$icon-symbolic \
  -h int:value:$volume
