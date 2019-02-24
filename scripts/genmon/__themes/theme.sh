#!/bin/bash

getCacheImage() {
  input=$1
  cachef=/tmp/argos-$(basename $input)

  if [ ! -f $cachef ]; then
    base64 -w 0 $input >> $cachef
  fi

  cat $cachef
}

theme="/home/marko/.scripts/themes/gnome"
itheme="$theme/icons"
