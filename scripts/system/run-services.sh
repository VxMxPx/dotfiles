#!/bin/bash

wal -i "$(< "${HOME}/.cache/wal/wal")"

(polybar default &)
(conky &)

# Cron services
(~/.resources/scripts/system/cron/check-updates-polybar.sh &)
(~/.resources/scripts/system/cron/update-calendar-from-google.sh &)
