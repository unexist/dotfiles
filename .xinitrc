#
# Xinitrc script
#
# Copyright (c) 2004-present, Christoph Kappel <christoph@unexist.dev>
#

# Config
#TERMINAL=urxvt
TERMINAL=alacritty

# Host
xhost +localhost
xhost +$HOST

# X options
xset -b
xset m 0 0
xsetroot -solid "#595959"

# Keymap
setxkbmap -layout 'de(nodeadkeys)'
setxkbmap -option caps:escape
setxkbmap -option compose:rctrl
setxkbmap -option terminate:ctrl_alt_bksp

# Xdefaults
if [ -e $HOME/.Xdefaults ] ; then
    xrdb ~/.Xdefaults
fi

# Xmodmap
if [ -e $HOME/.Xmodmap ] ; then
    xmodmap $HOME/.Xmodmap
fi

# Redshift
#if [ -e /usr/bin/redshift ] ; then
#  redshift -l 51.31:6.55 &
#fi

# xrandr
if [ -e /usr/bin/xrandr ] ; then
    if [ "xmeanas" = "x`hostname`" ] ; then
        xrandr \
            --output eDP-1 --primary --mode 1920x1200 --pos 0x0 \
            --output DP-1 --mode 2560x1080 --pos 1920x0 --right-of eDP-1 --dpi 96
    fi
fi

# Wallpaper
#if [ -e /usr/bin/feh ] ; then
#  if [ -e $HOME/.fehbg ] ; then
#    sh ~/.fehbg &
#  fi
#fi

# Windowmanager
#if [ "xsubtle" = "x$1" ] ; then
#  exec /home/unexist/projects/subtle/subtle >~/subtle.log &
#else
#  exec $1 &
#fi
/home/unexist/projects/subtle/subtle >~/subtle.log &
pid=$!

sleep 2

# Term
command -v $TERMINAL &>/dev/null

if [ $? -eq 0 ]; then

    # Attach to sessions if there are any
    command -v tmux &>/dev/null

    if [ $? -eq 0 ]; then
        for termname in term1 term2 ; do
            tmux has-session -t $termname

            if [ $? -eq 1 ]; then
                $TERMINAL --class $termname -e tmux new -s $termname &
            else
                $TERMINAL --class $termname -e tmux attach-session -t $termname &
            fi
        done
    else
        $TERMINAL --class term1 &
        $TERMINAL --class term2 &
    fi
fi

# Numlockx
command -v numlockx &>/dev/null

if [ $? -eq 0 ]; then
    numlockx >/dev/null &
fi

# autocutsel
command -v autocutsel &>/dev/null

if [ $? -eq 0 ]; then
    autocutsel -fork &
    autocutsel -selection PRIMARY -fork &
fi

# xinput
command -v xinput &>/dev/null

if [ $? -eq 0 ]; then
    xinput set-prop 9 "libinput Tapping Enabled" 1
    xinput set-prop 9 "libinput Middle Emulation Enabled" 1
fi

# Bluetooth
#command -v blueman-applet &>/dev/null

#if [ $? -eq 0 ]; then
#    blueman-applet &
#fi

# nm-tray
command -v nm-tray &>/dev/null

if [ $? -eq 0 ]; then
    nm-tray &
fi

# Flameshot
command -v flameshot &>/dev/null

if [ $? -eq 0 ]; then
    flameshot &
fi

# ssh-agent
command -v ssh-agent &>/dev/null

if [ $? -eq 0 ]; then
    eval "$(ssh-agent -s)"
fi

wait $pid
xinput set-prop 9 "libinput Tapping Enabled" 1
