#!/bin/sh

if ! events=$(khal list 2> /dev/null | tail -n +2 | wc -l); then
    events=0
fi

if [ "$events" -gt 1 ]; then
    echo $events
else
    echo ""
fi
