#
# Xinitrc script
#
# Copyright (c) 2004-2010, Christoph Kappel <unexist@dorfelite.net>
#

# Host
xhost +localhost
xhost +$HOST

# X options
xset -b
xset m 6 1
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
#if [ -e /usr/bin/xrandr ] ; then
#  if [ "xsubtle" = "x$1" ] ; then
#    xrandr --output DVI-0 --primary --mode 1680x1050 --pos 1680x0 --output HDMI-0 --mode 1680x1050 --pos 0x0 --left-of DVI-0 --dpi 96
#    #xrandr --output DFP1 --primary --mode 1680x1050 --pos 1680x0 --output DFP2 --mode 1680x1050 --pos 0x0 --right-of DFP1 --dpi 96
#  elif [ "xxbmc" = "x$1" ] ; then
#    xrandr --output DVI-0 --off --output HDMI-0 --mode 1920x1080
#    #xrandr --output DFP1 --off --output DFP2 --mode 1920x1080
#  fi
#fi

# Wallpaper
#if [ -e /usr/bin/feh ] ; then
#  if [ -e $HOME/.fehbg ] ; then
#    sh ~/.fehbg &
#  fi
#fi

# Windowmanager
#if [ "xsubtle" = "x$1" ] ; then
#  exec $1 -n &
#else
#  exec $1 &
#fi
/home/unexist/projects/subtle/subtle &
pid=$!

sleep 2

# Term
if [ -e /usr/bin/urxvt ] ; then
  /usr/bin/urxvt -name urxvt1 -urgentOnBell &

  # Attach to session if there is any
  if [ -e /usr/bin/tmux ] ; then
    tmux has-session

    if [ $? -eq 1 ]; then
      /usr/bin/urxvt -name urxvt2 -e tmux &
    else
      /usr/bin/urxvt -name urxvt2 -e tmux attach-session &
    fi
  fi
fi

# Numlockx
if [ -e /usr/bin/numlockx ] ; then
  /usr/bin/numlockx >/dev/null &
fi

wait $pid
