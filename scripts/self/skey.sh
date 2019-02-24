#!/bin/bash

# Set keymap
# Example: ./skey.sh us | ./skey.sh si

#IFS=' ' read -r -a layouts <<< $(xkblayout-state print %S)
layouts=$(xkblayout-state print %S)
layouts=($layouts)

for index in "${!layouts[@]}"; do
  if [ "${layouts[$index]}" == $1 ]; then
    echo "I shall set $index"
    xkblayout-state set $index
  fi
done

# setxkbmap $1
