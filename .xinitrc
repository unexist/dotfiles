#
# Xinitrc script
#
# Copyright (c) 2004-2009, Christoph Kappel <unexist@dorfelite.net>
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

# Xbindkeys
if [ -e /usr/bin/xbindkeys ] && [ -e $HOME/.xbindkeysrc ] ; then
  xbindkeys
fi

# xrandr
if [ -e /usr/bin/xrandr ] ; then
  xrandr --output DFP1 --mode 1680x1050 --pos 0x0 --output DFP4 --mode 1680x1050 --pos 1680x0 --right-of DFP1
  #xrandr --output DFP1 --mode 1680x1050 --pos 0x0 --output DFP4 --mode 1920x1080 --pos 1680x0 --right-of DFP1
fi

# Windowmanager
#valgrind --tool=memcheck subtle &> ~/subtle.log &
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

# Cookie daemon
#if [ -e $HOME/bin/cookie_daemon.py ] ; then
#  $HOME/bin/cookie_daemon.py &
#fi

wait $pid
