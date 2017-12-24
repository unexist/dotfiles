#
# @file Zsh profile
#
# @copyright (c) 2006-2016, Christoph Kappel <unexist@dorfelite.net>
# @version $Id$
#

# Colors
export ZLS_COLORS=`dircolors | sed s/LS/ZLS/ | head -n 1`

# Modules
autoload complist
autoload -U compinit
autoload edit-command-line
autoload -U colors
zle -N edit-command-line

# Completion
compinit
compdef -d hg # Disable slow completion for mercurial
compdef -d grep
compdef -d mplayer
compdef -d chmod
colors

# Style
zstyle ':completion:*' group-name '' #< Sort completion groups
zstyle ':completion:*' menu select #< Enable menu list

# Options
setopt correct
setopt hist_ignore_all_dups
setopt autocd
setopt extended_glob
setopt extended_history
setopt append_history
setopt auto_resume
setopt auto_continue
setopt auto_pushd
setopt multios
setopt short_loops
setopt listpacked
setopt pushd_ignore_dups
setopt prompt_subst
setopt no_beep
#setopt rm_star_wait
unsetopt bang_hist #< Disable inline history
setopt no_bang_hist
#setopt menu_complete
setopt promptsubst

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000

# Style
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' 

# Keys bindings
bindkey "^e" edit-command-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^t" transpose-chars
bindkey "^q" quote-line
bindkey "^k" kill-line
bindkey "^w" delete-word

bindkey "\e[1~" beginning-of-line
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[3~" delete-char

# History search
#zle -N search-backwords
#bindkey "^R" search-backwords
bindkey "^R" history-incremental-search-backward

# Functions
function pastie
{
  url=$(curl http://pastie.caboo.se/pastes/create \
    -H "Expect:" \
    -F "paste[parser]=plain_text" \
    -F "paste[body]=<-" \
    -F "paste[authorization]=burger" \
    -s -L -o /dev/null -w "%{url_effective}")
  echo -n "$url" | xclip
  echo "$url"
}

function imgur
{
  for i in "$@"; do
    curl -s -F "image=@$i" -F "key=d159f6eac3eaf0205acbdb5a85ca3659" http://imgur.com/api/upload.xml | grep -E -o "<original_image>(.)*</original_image>" | grep -E -o "http://i.imgur.com/[^<]*"
    curl -H "Authorization: Client-ID 3e7a4deb7ac67da" -F image=@$i \
      https://api.imgur.com/3/upload | sed 's/.*http/http/; s/".*/\n/; s,\\/,/,g'

  done
}

function search-backwords {
   zle history-incremental-search-backward $BUFFER
}

function rc
{
  sudo /etc/rc.d/$*
}

function ansi-colors
{
  typeset esc="\033[" line1 line2
  echo " _ _ _40 _ _ _41_ _ _ _42 _ _ 43_ _ _ 44_ _ _45 _ _ _ 46_ _ _ 47_ _ _ 49_ _"
  for fore in 30 31 32 33 34 35 36 37; do
    line1="$fore "
    line2="   "
    for back in 40 41 42 43 44 45 46 47 49; do
      line1="${line1}${esc}${back};${fore}m Normal ${esc}0m"
      line2="${line2}${esc}${back};${fore};1m Bold   ${esc}0m"
    done
    echo -e "$line1\n$line2"
  done
}

function pp
{
  for i in *.(mov|mkv|avi|wmv|mp[1-9]); do
    DISPLAY=:0 mplayer -vo x11 -nosound -zoom -fs "$i"

    echo -n "Keep? (Y/n) "
    read keep

    if [ "x$keep" = "xn" ] ; then
      rm -rf "$i"
    fi
  done
}

function convico
{
  convert "$1" -resize $2 ${2}x${2}.png
}

function t
{
  if ! [ -z "$TMUX" ]; then
    tmux new-window -c $PWD
  fi
}

# Prompt
if [ "$USER" = "root" ] ; then
  PS1=%1~$'%{\e[36;1m%}%(1j.%%%j.)%{\e[30;1m%} ➤ %{\e[0m%}'
else
  PS1=%1~$'%{\e[36;1m%}%(1j.%%%j.)%{\e[34;1m%} ➤ %{\e[0m%}'
fi

PS1=$'${(r:$COLUMNS::\u2500:)}'$PS1
#PS1=$'%{\e(0%}${(r:$COLUMNS::q:)}%{\e(B%}'$PS1
#PS1=$'${(r:$COLUMNS::-:)}'$PS1

umask 022

# Fix broken locales in arch
export LC_CTYPE="en_US.UTF-8"

# Man search order
export MANSECT="2:3:3p:1:1p:8:4:5:6:7:9:0p:tcl:n:l:p:o:1x:2x:3x:4x:5x:6x:7x:8x"

# Extending the path var
if [ -e $HOME/bin ] ; then
  export PATH=$HOME/bin:$PATH
fi

# Adding go stuff
if [ -e $HOME/google_appengine ] ; then
  export PATH=$HOME/google_appengine:$PATH
fi

# Adding android stuff
if [ -e /opt/android-sdk ] ; then
  export PATH=/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/opt/android-sdk/build-tools/20.0.0:$PATH
fi

if [ -e /opt/android-sdk/tools ] ; then
  export PATH=/opt/android-sdk/tools:$PATH
fi

# Sencha stuff
export PATH=/home/unexist/bin/Sencha/Cmd/3.0.0.250:$PATH
export SENCHA_CMD_3_0_0="/home/unexist/bin/Sencha/Cmd/3.0.0.250"

# Setting default editor
if [ -f /usr/bin/vim ] ; then
  export EDITOR=/usr/bin/vim
fi

# PostgreSQL
if [ -f /usr/bin/psql ] ; then
  export PGDATA=/home/unexist/misc/postgres
  export PGUSER=unexist
  export PGDATABASE=unexist
fi

# XDG dirs
if [ -e "$HOME/.config/user-dirs.dirs" ] ; then
  source $HOME/.config/user-dirs.dirs
fi

# Browser
export BROWSER="/usr/bin/chromium"

# Update title
case $TERM in
  xterm*|urxvt*|screen*)
    chpwd() { print -Pn "\e]0;%n@%m: %~\a" }
    ;;
esac

# Aliases
if [ -f $HOME/.zshalias ] ; then
  source $HOME/.zshalias
fi

# Keychain
if [ -f /usr/bin/keychain ] ; then
  if ! [ -f $HOME/.keychain/$HOST-sh ] ; then
    keychain -q --nocolor --nogui id_rsa
  fi

  source $HOME/.keychain/$HOST-sh
fi

# Pebble
if [ -e $HOME/projects/pebble/PebbleSDK-2.0-BETA3 ] ; then
  export PATH=/home/unexist/projects/pebble/PebbleSDK-2.0-BETA3/bin:$PATH
fi

if [ -e /home/unexist/projects/arm-cs-tools/bin ] ; then
  export PATH=/home/unexist/projects/arm-cs-tools/bin:$PATH
fi

# RVM
if [ -s "$HOME/.rvm/scripts/rvm" ] ; then
  source "$HOME/.rvm/scripts/rvm"

  # Add RVM to PATH for scripting
  PATH=$PATH:$HOME/.rvm/bin
fi

# Pebble
if [ -d $HOME/projects/pebble ] ; then
  # Add pebble to PATH for scripting
  PATH=$PATH:$HOME/projects/pebble/pebble-sdk-4.3-linux64/bin
fi

# JAVA
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
