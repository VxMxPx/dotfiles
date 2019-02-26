#!/bin/bash

cd ~/.themes
rm -rf 4dyne
cp -R 4dyne-base 4dyne

cd 4dyne/xfwm4

COLORS=~/.cache/wal/colors
COLORBG=$(head -n 1 "$COLORS")
COLORFG=$(head -n 3 "$COLORS" | tail -n 1)

find . -name '*.xpm' -exec sed -i -e "s/#303030/$COLORBG/g" {} \;
find . -name '*.xpm' -exec sed -i -e "s/#888888/$COLORFG/g" {} \;

(xfwm4 --replace &)

