#!/bin/sh
WGET=/usr/bin/wget
OPTIONS="-c --user-agent=Firefox --load-cookies $XDG_DATA_HOME/cookies/rapidshare --limit 700k"

cd $HOME/downloads

$WGET $OPTIONS $8
