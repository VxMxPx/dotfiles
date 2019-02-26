#!/bin/bash

ICAL=$(head -n 1 ~/.resources/private/google-calendar.url)
DEST=~/.cache/google-calendar-private.ics

curl $ICAL > $DEST

rm ~/.local/share/khal/calendars/google/*

khal import -a google --batch $DEST

rm $DEST
