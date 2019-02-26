#!/bin/sh

if ! updates=$(checkupdates 2> /dev/null | wc -l); then
    updates=0
fi

if [ "$updates" -gt 10 ]; then
    echo $updates
else
    echo ""
fi
