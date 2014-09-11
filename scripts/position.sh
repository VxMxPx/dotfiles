#!/bin/bash

# Expecting one parameter: active window position (from left)
function getScreenSettings () {
    screen=(
        # Desktop settings
        [decoration_height]=12 # Windows decoration size height
        [decoration_width]=4   # Windows decoration size width
        # Screen defaults
        [width]=0          # Screen width
        [height]=0         # Screen height
        [top]=0            # Actual position of screen (from top)
        [left]=0           # Actual position of screen (from left)
        [padding_top]=0    # Padding top (for example if there's panel on top)
        [padding_right]=0  # Padding right
        [padding_bottom]=0 # Padding bottom
        [padding_left]=0   # Padding left
    )

    if [[ $1 -le 1674 ]];
    then
        # Set the LEFT screen
        screen[width]=1680
        screen[height]=1050
        screen[padding_bottom]=24
        screen[padding_left]=0
    else
        # Set the RIGHT screen
        screen[width]=1920
        screen[height]=1080
        screen[left]=1680
        screen[top]=0
    fi

    # Calculate usable region of screen
    screen[usable_width]=$(( ${screen[width]} - ${screen[padding_left]} - ${screen[padding_right]} ))
    screen[usable_height]=$(( ${screen[height]} - ${screen[padding_top]} - ${screen[padding_bottom]} ))
}

# Get current active window
function getActiveWindow() {
    # Remove Window's Maximized or full screen state.
    # wmctrl -r :ACTIVE: -b remove,fullscreen
    # wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz

    # Get scree size for current window
    window[active]=$(xdotool getactivewindow)
    window[position]=$( xdotool getwindowgeometry ${window[active]} | grep -E Position: )
    regex="Position: ([0-9]+),([0-9]+)"
    [[ ${window[position]} =~ $regex ]]

    window[left]=${BASH_REMATCH[1]}
    window[top]=${BASH_REMATCH[2]}
}

# Accept parameter: top | left | right | bottom
# Return calculated coordinate top or left
function getPostionCords() {
    if [[ $1 == "top" ]]; then
        echo $(( ${screen[top]} + ${screen[padding_top]} ))
    elif [[ $1 == "bottom" ]]; then
        echo $(( (${screen[usable_height]} / 2) + ${screen[padding_top]} ));
    elif [[ $1 == "left" ]]; then
        echo $(( ${screen[left]} + ${screen[padding_left]} ))
    elif [[ $1 == "right" ]]; then
        echo $(( ${screen[left]} + (${screen[usable_width]} / 2) + ${screen[padding_left]} ))
    else
        echo "Invalid position parameter: " $1
        exit 1
    fi
}

# Accept parameter: fully | fullx | halfy | halfx
# Return calculated size: width or height
function getSize() {
    if [[ $1 == "fully" ]]; then
        echo $(( ${screen[usable_height]} - ${screen[decoration_height]} ))
    elif [[ $1 == "fullx" ]]; then
        echo $(( ${screen[usable_width]} - ${screen[decoration_width]} ))
    elif [[ $1 == "halfy" ]]; then
        echo $(( (${screen[usable_height]} / 2) - ${screen[decoration_height]} ))
    elif [[ $1 == "halfx" ]]; then
        echo $(( (${screen[usable_width]} / 2) - ${screen[decoration_width]} ))
    else
        echo "Invalid size parameter: " $1
        exit 1
    fi
}

function centerWindow() {
    updatePositionAndSize \
        $1 \
        $(( ${screen[padding_top]} + (${screen[usable_height]} / 4))) \
        $(( ${screen[left]} + (${screen[usable_width]} / 4))) \
        $(( ${screen[usable_width]} / 2 )) \
        $(( ${screen[usable_height]} / 2 ))
}

# Update active window's position and size
# Required parameters
#   1:int:active_window
#   2:int:top
#   3:int:left
#   4:int:width
#   5:int:height
function updatePositionAndSize() {
    # Remove Window's Maximized or full screen state.
    wmctrl -r :ACTIVE: -b remove,fullscreen
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz

    if [[ $debug == "true" ]]; then
        echo "Debug mode..."
        echo "Window:" $1
        echo "Top" $2
        echo "Left:" $3
        echo "Width:" $4
        echo "Height:" $5
    fi

    xdotool windowmove $1 $3 $2
    xdotool windowsize $1 $4 $5
}

# Run the script!
function selfRun() {
    # Declare global variables
    declare -A window
    declare -A screen

    # Wait fot app-finder to actually close
    while [[ $(xdotool getactivewindow getwindowname | grep -E "Application Finder") ]]; do
        sleep 0.1
    done

    # Get active window
    getActiveWindow

    # Get screen variables...
    getScreenSettings ${window[left]}

    # Where to position the window?
    # top, right, bottom, left, center, top-left, top-right, bottom-left, bottom-right
    newPosition=$1
    debug=false
    [[ $2 == "-d" ]] && debug=true

    # TOP ------------------------------
    if [[ $newPosition == "top" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords top) $(getPostionCords left) \
            $(getSize fullx) $(getSize halfy)
    # RIGHT ------------------------------
    elif [[ $newPosition == "right" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords top) $(getPostionCords right) \
            $(getSize halfx) $(getSize fully)
    # BOTTOM ------------------------------
    elif [[ $newPosition == "bottom" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords bottom) $(getPostionCords left) \
            $(getSize fullx) $(getSize halfy)
    # LEFT ------------------------------
    elif [[ $newPosition == "left" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords top) $(getPostionCords left) \
            $(getSize halfx) $(getSize fully)
    # TOP-LEFT ------------------------------
    elif [[ $newPosition == "tleft" || $newPosition == "leftt" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords top) $(getPostionCords left) \
            $(getSize halfx) $(getSize halfy)
    # TOP-RIGHT ------------------------------
    elif [[ $newPosition == "tright" || $newPosition == "rightt" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords top) $(getPostionCords right) \
            $(getSize halfx) $(getSize halfy)
    # BOTTOM-LEFT ------------------------------
    elif [[ $newPosition == "bleft" || $newPosition == "leftb" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords bottom) $(getPostionCords left) \
            $(getSize halfx) $(getSize halfy)
    # BOTTOM-RIGHT ------------------------------
    elif [[ $newPosition == "bright" || $newPosition == "rightb" ]]; then
        updatePositionAndSize \
            ${window[active]} \
            $(getPostionCords bottom) $(getPostionCords right) \
            $(getSize halfx) $(getSize halfy)
    elif [[ $newPosition == "center" ]]; then
        centerWindow ${window[active]}
    else
        echo "Invalid parameter:" $newPosition
        exit 1
    fi
}

selfRun $1 $2

# Repeat command if we're in terminal
[[ $(xdotool getactivewindow getwindowname | grep -E "Terminal - ") != ""  ]] && selfRun $1 $2;

exit 0
