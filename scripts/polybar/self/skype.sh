#!/bin/bash

skype=$(wmctrl -l | grep "Skype \[")

if [[ $skype ]]; then

    messages=$(echo $skype | awk '{ print substr($5, 2, length($5) -2) }')

    if [[ "x$messages" != "x" ]]; then
      echo $messages
      exit 0
    fi
fi

echo ""
