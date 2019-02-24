#!/bin/bash

# Helper for setting blickstick state. See list of available commands at the bottom.

function set_state {
  index=$1
  color=$2
  other=$3
  if [[ $index == '.' ]]; then
    IFS=',' read -ra colors <<< "$color"
    lastcolor='#000000'
    for diod in $(seq 0 $cdiods); do
      [ ${colors[$diod]+y} ] && lastcolor=${colors[$diod]}
      set_state $diod $lastcolor $other
    done
  else
    blinkstick $other --index $index --set-color $color
  fi
}

function get_state {
  index=$1
  IFS=',' read -ra colors <<< "$diods"
  echo ${colors[$index]}
}

function write_state {
  if [[ "x$1" != 'x' ]]; then
    diods=$1
  fi
  echo -e "diods=\"$diods\"\nstate=\"$state\"\nsuspended=\"$suspended\"" > $fconfig
}

function clear_state {
  write_state ""
}

function suspendme {
  if [[ $1 == 'on' ]]; then
    suspended='yes'
    write_state
    off
  else
    suspended='no'
    write_state
    on
  fi
}

function off {
  if [[ $1 == 'write' ]]; then
    state='off'
    write_state
  fi
  set_state . off
}

function on {
  if [[ $1 == 'write' ]]; then
    state='on'
    write_state
  fi
  set_state . $diods
}

function flash {
  if [[ $state == 'off' || $suspended == 'yes' ]]; then exit 0; fi
  index=$1
  color=$2
  original=$(get_state $1)
  set_state $index $color
  sleep 0.6
  set_state $index "off"
  if [[ $state != 'off' ]]; then
    set_state $index $original
  fi
}

function monitor {

  sleep_time=15

  while true; do

    # Source config again
    . $fconfig

    # Idle?
    #idle=$(light-locker-command -t | grep -Eo "[0-9]+")
    #idle=$(qdbus org.freedesktop.ScreenSaver /ScreenSaver org.freedesktop.ScreenSaver.GetSessionIdleTime)
    #idle=$(echo "$idle/1000" | bc)

    #if (( idle > 300 )); then
    #  suspended="true"
    #  off
    #  sleep $sleep_time
    #  continue
    #fi

    # Do not care if turned off
    if [[ $state != 'off' ]]; then
      #get id of active window and clean output
      activ_win_id=`xprop -root _NET_ACTIVE_WINDOW`
      #activ_win_id=${activ_win_id#*# } #gives error if xprop returns extra ", 0x0" (happens on some distros)
      activ_win_id=${activ_win_id:40:9}

      # Check if Active Window (the foremost window) is in fullscreen state
      isActivWinFullscreen=`xprop -id $activ_win_id | grep _NET_WM_STATE_FULLSCREEN`

      if [[ "$isActivWinFullscreen" = *NET_WM_STATE_FULLSCREEN* ]]; then
        suspendme 'on'
      else
        if [[ $suspended == "yes" ]]; then
          suspendme 'off'
        fi
      fi
    fi

    sleep $sleep_time
  done
}

# Some global variables
cdiods=29; # zero based
fconfig="/home/$USER/.config/blinkstick-state.conf"

# Source config
. $fconfig

# Decide on parameter
case $1 in
  "set")
    set_state $2 $3
    ;;

  "get")
    get_state $2
    ;;

  "write")
    write_state $2
    ;;

  "clear")
    clear_state
    ;;

  "off")
    off $2
    ;;

  "on" | "restore")
    on $2
    ;;

  "flash")
    flash $2 $3
    ;;

  "status")
    echo $state
    ;;

  "toggle")
    if [[ $state == 'on' ]]; then
      off 'write'
    else
      on 'write'
    fi
    ;;

  "monitor")
    monitor
    ;;

  *)
    echo "List of available commands"
    echo ""
    echo "  set INDEX COLOR         Set color for LED."
    echo "      INDEX can be        LED index or . for all."
    echo "  get INDEX               Get color at index."
    echo "  write COLORS            Write colors composition to a file."
    echo "  clear                   Clear currently written state."
    echo "  off                     Turn all LEDs off."
    echo "  on                      Turn all LEDs on, read from sate file."
    echo "  flash INDEX COLOR       Flash a LED to color."
    echo "  status                  On/off status."
    echo "  toggle                  Toggle on/off."
    echo "  monitor                 Switch LEDs off if full screen application."
    echo ""
esac
