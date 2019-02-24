#!/bin/bash

# Toggle keyboard on/off.

Icon="~/.resources/resources/icons/keyboard/on.png"
Icoff="~/.resources/resources/icons/keyboard/off.png"
fconfig=".keyboard" 
id=13

if [ ! -f $fconfig ];
    then
        echo "Creating config file"
        echo "enabled" > $fconfig
        var="enabled"
    else
        read -r var< $fconfig
        echo "keyboard is : $var"
fi

if [ $var = "disabled" ];
    then
        notify-send -i $Icon "Enabling keyboard..." \ "ON - Keyboard connected !";
        echo "enable keyboard..."
        xinput enable $id
        echo "enabled" > $fconfig
    elif [ $var = "enabled" ]; then
        notify-send -i $Icoff "Disabling Keyboard" \ "OFF - Keyboard disconnected";
        echo "disable keyboard"
        xinput disable $id
        echo 'disabled' > $fconfig
fi
