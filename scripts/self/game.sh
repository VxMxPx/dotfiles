#!/bin/bash

# Will set some performance tweaks, so that computer will be more gaming friendly.
# Example: ./game.sh on | ./game.sh off

home="~/.resources/scripts/self"
compositing=$(xfconf-query -c xfwm4 -p /general/use_compositing)

if [[ $1 == "on" ]]; then
  killall -8 chromium
  killall -15 xfce4-panel
  killall -15 redshift
  killall -15 subl3
  $home/display-toggle.sh off
  if [[ $compositing == "true" ]]; then
    $home/compositing.sh
  fi
else
  chromium &
  xfce4-panel &
  redshift -l 46.422713:15.748901 -m randr -r &
  $home/display-toggle.sh on
  if [[ $compositing == "false" ]]; then
    $home/compositing.sh
  fi
fi
