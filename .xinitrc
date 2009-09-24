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

# xrandr
#if [ -e /usr/bin/xrandr ] ; then
  #/usr/bin/xrandr --output VGA --right-of LVDS
  #/usr/bin/xrandr --output LVDS --mode 1400x1050 --pos 0x0 --output VGA --mode 1680x1050 --pos 1400x0 --right-of LVDS
  #/usr/bin/xrandr --output LVDS --mode 1280x960 --output VGA --mode 1680x1050 --above LVDS
  xrandr --output DFP1 --mode 1680x1050 --pos 0x0 --output DFP4 --mode 1680x1050 --pos 1680x0 --right-of DFP1
#fi

# Windowmanager
#valgrind --tool=memcheck subtle &> ~/subtle.log &
subtle &
pid=$!

sleep 2

# Term
if [ -e /usr/bin/urxvt ] ; then
  /usr/bin/urxvt -name top --perl-lib /home/unexist/.urxvt/ -pe mark-yank-urls &
  /usr/bin/urxvt -name bottom --perl-lib /home/unexist/.urxvt/ -pe mark-yank-urls &
fi

# Numlockx
if [ -e /usr/bin/numlockx ] ; then
  /usr/bin/numlockx >/dev/null &
fi

# Cookie daemon
if [ -e $HOME/bin/cookie_daemon.py ] ; then
  $HOME/bin/cookie_daemon.py &
fi

wait $pid
