#!/bin/bash

# mv <desktop> [screen] [position]
# mv 1          - move to the first desktop
# mv 2 >        - move to the second desktop, right screen
# mv 3 <        - move to the third desktop, left screen
# mv 4 . center - move to the fourth desktop, keep the screen, position center
# mv . >        - move to the right screen
# mv . . left   - position left (same as 'left' command)

# Wait fot app-finder to actually close
while [[ $(xdotool getactivewindow getwindowname | grep -E "Application Finder") ]]; do
    sleep 0.1
done

screen_left=1680
screen1_top=0
screen2_top=0
desktop=$1
screen=$2
position=$3
active=$(xdotool getactivewindow)

# Check if we have omited desktop completely
if [[ $desktop == "<" || $desktop == ">" ]]; then
    screen=$desktop
    desktop=""
fi

# Move to the another desktop
if [[ $desktop != "" && $desktop != "." ]]; then
    source $(dirname $0)/to $desktop
    desktop=$(( $desktop - 1 ))
    xdotool set_desktop_for_window $active $desktop
    xdotool windowactivate $active;
fi

# Move to the another screen
if [[ $screen != "" && $screen != "." ]]; then
    window_position=$( xdotool getwindowgeometry $active | grep -E Position: );
    regex="Position: ([0-9]+),([0-9]+)";
    [[ $window_position =~ $regex ]];
    left=${BASH_REMATCH[1]};
    top=${BASH_REMATCH[2]};

    wmctrl -r :ACTIVE: -b remove,fullscreen
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz

    if [[ $left < 0 ]]; then
        left=0
    fi

    if [[ $screen == "<" ]]; then
        xdotool windowmove $active $(( $left - $screen_left)) $(( $top - $screen2_top ));
    else
        xdotool windowmove $active $(( $screen_left + $left)) $(( $top - $screen1_top ));
    fi
fi

# Change position
if [[ $position != "" &&  $position != "." ]]; then
    sleep 0.2
    # Catalog of position
    source $(dirname $0)/position.sh $position
fi

exit 0
