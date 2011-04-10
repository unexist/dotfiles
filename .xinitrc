#
# Xinitrc script
#
# Copyright (c) 2004-2010, Christoph Kappel <unexist@dorfelite.net>
#

# Host
xhost +localhost
xhost +$HOST

# X options
xset m 7 1
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
  #xrandr --output DFP1 --mode 1680x1050 --pos 0x0 --output DFP2 --mode 1680x1050 --pos 1680x0 --right-of DFP1 --dpi 96
  xrandr --output DVI-0 --primary --mode 1680x1050 --pos 1680x0 --output HDMI-0 --mode 1680x1050 --pos 0x0 --right-of DVI-0 --dpi 96
  #xrandr --output udlfb --mode 1680x1050 --pos 0x0 --dpi 96
fi

# Wallpaper
#if [ -e /usr/bin/feh ] ; then
#  if [ -e $HOME/.fehbg ] ; then
#    sh ~/.fehbg &
#  fi
#fi

# Windowmanager
#valgrind --tool=memcheck --leak-check=full --suppressions=$HOME/.suppressions subtle &> ~/subtle.log &
#subtle &> ~/subtle.log &
subtle &
#$HOME/projects/subtle/subtle &
pid=$!

sleep 2

# Term
if [ -e /usr/bin/urxvt ] ; then
  /usr/bin/urxvt -name urxvt1 -urgentOnBell &
  /usr/bin/urxvt -name urxvt2 &
fi

# Numlockx
if [ -e /usr/bin/numlockx ] ; then
  /usr/bin/numlockx >/dev/null &
fi

wait $pid
