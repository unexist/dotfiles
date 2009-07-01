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

# Windowmanager
# awesome &
subtle &
pid=$!

sleep 2

# xrand
if [ -e /usr/bin/xrandr ] ; then
  /usr/bin/xrandr --output LVDS --off
fi

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

wait $pid
