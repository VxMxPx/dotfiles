#!/bin/bash

while true
do
  if ! ~/.resources/scripts/polybar/self/updates-arch.sh; then
    polybar-msg hook updates-arch 1 >/dev/null 2>&1
  else
    polybar-msg hook updates-arch 2 >/dev/null 2>&1
  fi
  sleep 1200
done
