#!/bin/zsh

FILE="/sys/class/rfkill/rfkill0/state"
STATE=`cat $FILE`

if [ "x0" = "x$STATE" ] ; then
  echo 1 > $FILE
else
  echo 0 > $FILE
fi
