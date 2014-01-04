#!/bin/bash

value=$(kdialog \
--title "Please select timeout..." \
--default 2min \
--combobox "Set time for your tea..." Costume... 2min 3min 5min)

if [[ $value == "Costume..." ]]; then
    value=$(kdialog \
--title "Please enter timeout: Ns | Nm" \
--inputbox Timeout 2min)
fi

echo $value
