#
# Xinitrc script
#
# Copyright (c) 2004-2009, Christoph Kappel <unexist@dorfelite.net>
#

# Host
xhost +localhost
xhost +meanas

# X options
xset m 7/1
xsetroot -bg "#666666"
setxkbmap -layout 'de(nodeadkeys)'

# xrandr
if [ -e /usr/bin/xrandr ] ; then
  #/usr/bin/xrandr --output VGA --right-of LVDS
  #/usr/bin/xrandr --output LVDS --mode 1400x1050 --pos 0x0 --output VGA --mode 1680x1050 --pos 1400x0 --right-of LVDS
  /usr/bin/xrandr --output LVDS --mode 1280x960 --output VGA --mode 1680x1050 --above LVDS
fi

# Windowmanager
subtle &> ~/subtle.log &
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

# Wicd
if [ -e /usr/bin/wicd-client ] ; then
  /usr/bin/wicd-client >/dev/null &
fi

# Bfilter
if [ -e /usr/bin/bfilter-gui ] ; then
  /usr/bin/bfilter-gui >/dev/null &
fi

wait $pid
