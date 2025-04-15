#!/bin/zsh

if [ "xsingle" = "x$1" ] ; then
    xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x0 --dpi 96
elif [ "xcurved" = "x$1" ] ; then
    xrandr \
        --output DP-3 --mode 5120x1440 --pos 0x0 --primary \
        --output eDP-1 --mode 1920x1200 --pos 1920x0 --right-of DP-3 \
        --dpi 96
elif [ "xwork" = "x$1" ] ; then
    xrandr --output eDP-1 --mode 1920x1200 --pos 0x0 \
        --output DP-1 --mode 1920x1080 --pos 3840x0 --right-of eDP-1 --primary \
        --output DP-4-2 --mode 1920x1080 --pos 1920x0 --right-of DP-1 \
        --dpi 96
else
    xrandr --output eDP-1 --mode 1920x1200 --pos 0x0 \
        --output DP-1 --mode 2560x1080 --primary --pos 1920x0 --right-of eDP-1 \
        --dpi 96
fi

#subtler -R
