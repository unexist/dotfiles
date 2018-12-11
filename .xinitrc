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
if [ -e /usr/bin/xrandr ] ; then
  if [ "xazath" = "x`hostname`" ] ; then
    xrandr \
      --output eDP-1 --primary --mode 1366x768 --pos 0x0 \
      --output DP-2-2 --mode 1920x1200 --pos 768x0 --right-of eDP-1 \
      --output DP-2-3 --mode 1920x1080 --pos 2688x0 --right-of DP-2-2 --rotate left --dpi 96
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

if [ -e /usr/bin/autocutsel ] ; then
  /usr/bin/autocutsel -fork &
  /usr/bin/autocutsel -selection PRIMARY -fork &
fi

wait $pid
