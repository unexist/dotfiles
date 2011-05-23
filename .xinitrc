#
# Xinitrc script
#
# Copyright (c) 2004-2010, Christoph Kappel <unexist@dorfelite.net>
#

# Host
xhost +localhost
xhost +$HOST

# X options
xset m 4 2
xsetroot -solid "#595959"
setxkbmap -layout 'de(nodeadkeys)'
setxkbmap -option compose:caps

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
  if [ "xsubtle" = "x$1" ] ; then
    xrandr --output DVI-0 --primary --mode 1680x1050 --pos 1680x0 --output HDMI-0 --mode 1680x1050 --pos 0x0 --right-of DVI-0 --dpi 96
  elif [ "xxbmc" = "x$1" ] ; then
    xrandr --output DVI-0 --off --output HDMI-0 --mode 1920x1080
  fi
fi

# Wallpaper
#if [ -e /usr/bin/feh ] ; then
#  if [ -e $HOME/.fehbg ] ; then
#    sh ~/.fehbg &
#  fi
#fi

# Windowmanager
exec $1 &
pid=$!

sleep 2

# Term
if [ -e /usr/bin/urxvt ] && [ "xxbmc" != "x$1" ] ; then
  /usr/bin/urxvt -name urxvt1 -urgentOnBell &
  /usr/bin/urxvt -name urxvt2 -e tmux &
fi

# Numlockx
if [ -e /usr/bin/numlockx ] ; then
  /usr/bin/numlockx >/dev/null &
fi

wait $pid
