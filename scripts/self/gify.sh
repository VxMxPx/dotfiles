#!/bin/bash

# Example: ./gify.sh <input> <length [5]> <time [00:00:00]> <resolution [640]> <fps [10]> 

echo -e "\n\tUsage: <input> <length [5]> <time [00:00:00]> <resolution [640]> <fps [10]>"

if [[ "x$1" != "x" ]]
then
    # Assign Video
    video=$1

    # Assign Length
    length=$([ "x$2" != "x" ] && echo $2 || echo "5")

    # Assign Start Time
    start=$([ "x$3" != "x" ] && echo $3 || echo "00:00:00")

    # Assign Resolution
    resolution=$([ "x$4" != "x" ] && echo $4 || echo "640")

    # Assign Frame Rate
    fps=$([ "x$5" != "x" ] && echo $5 || echo "10")

    mkdir frames
    ffmpeg -i "$video" -t $length -ss $start -vf scale=$resolution:-1:flags=lanczos,fps=$fps frames/ffout%03d.png
    convert -loop 0 frames/ffout*.png "${video%%.*}.gif"
    rm -rf frames

    echo -e "\n\tOutput: ${video%%.*}.gif"
    eog "${video%%.*}.gif"
fi
