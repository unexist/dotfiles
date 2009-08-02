#!/bin/zsh
WGET="/usr/bin/wget --user-agent=Firefox -c --load-cookies $XDG_DATA_HOME/cookies/rapidshare --limit 700k"

cd $HOME/downloads
$WGET $8
