#
# Xinitrc script
#
# Copyright (c) 2004-2010, Christoph Kappel <unexist@dorfelite.net>
#

# Host
xhost +localhost
xhost +$HOST

# X options
xset m 7/1
xsetroot -bg "#666666"
setxkbmap -layout 'de(nodeadkeys)'

# Xmodmap
if [ -e $HOME/.Xmodmap ] ; then
  xmodmap $HOME/.Xmodmap
fi

# Xflux
#if [ -e /usr/bin/xflux ] ; then
#  xflux -l 51.32
#fi

# xrandr
if [ -e /usr/bin/xrandr ] ; then
  xrandr --output DFP1 --mode 1680x1050 --pos 0x0 --output DFP4 --mode 1680x1050 --pos 1680x0 --right-of DFP1 --dpi 96
fi

# Windowmanager
#valgrind --tool=memcheck --suppressions=/home/unexist/.suppressions subtle &> ~/subtle.log &
subtle &
pid=$!

sleep 2

# Term
if [ -e /usr/bin/urxvt ] ; then
  /usr/bin/urxvt -name urxvt1 --perl-lib /home/unexist/.urxvt/ -pe mark-yank-urls &
  /usr/bin/urxvt -name urxvt2 --perl-lib /home/unexist/.urxvt/ -pe mark-yank-urls &
fi

# Numlockx
if [ -e /usr/bin/numlockx ] ; then
  /usr/bin/numlockx >/dev/null &
fi

wait $pid
