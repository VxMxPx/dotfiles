#!/bin/bash

messages=$(wmctrl -l | grep " — Yandex.Mail" | awk '{ print $4 }')
regex='^[0-9]+$'

if [[ $messages =~ $regex ]]; then
  echo $messages
  exit 0
fi

echo ""
