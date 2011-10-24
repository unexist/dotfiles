#
# @file Zsh profile
#
# @copyright (c) 2006-2011, Christoph Kappel <unexist@dorfelite.net>
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
function vman
{ 
  /usr/bin/man $* | col -b | view -c 'set ft=man nomod nolist' -
}

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

function toggle-asound
{
  if [ -e /etc/asound.conf ] ; then
    echo "asound.conf -> asound_conf"
    sudo mv /etc/asound.conf /etc/asound_conf
  elif [ -e /etc/asound_conf ] ; then
    echo "asound_conf -> asound.conf"
    sudo mv /etc/asound_conf /etc/asound.conf
  fi
}

function chpwd
{
  RPROMPT="%F{black}[$DISPLAY/${RUBY_VERSION/ruby-/}]%f"
}

# Prompt
if [ "$USER" = "root" ] ; then
  PS1=%1~$'%{\e[36;1m%}%(1j.%%%j.)%{\e[30;1m%}> %{\e[0m%}'
else
  PS1=%1~$'%{\e[36;1m%}%(1j.%%%j.)%{\e[34;1m%}> %{\e[0m%}'
fi

#RPROMPT="%F{black}[$DISPLAY/${RUBY_VERSION/ruby-/}]%f"

umask 022

# Fix broken locales in arch
export LC_CTYPE="en_US.UTF-8"

# Man search order
export MANSECT="2:3:3p:1:1p:8:4:5:6:7:9:0p:tcl:n:l:p:o:1x:2x:3x:4x:5x:6x:7x:8x"

# Extending the path var
if [ -e $HOME/bin ] ; then
  export PATH=$HOME/bin:$PATH
fi

# Adding android stuff
export PATH=$PATH:/opt/android-sdk/platform-tools

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
export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_TEMPLATES_DIR=$HOME
export XDG_PUBLICSHARE_DIR=$HOME
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_PICTURES_DIR="$HOME/images"
export XDG_VIDEOS_DIR="$HOME/media/videos"

# Git
if [ -e /usr/bin/git ] ; then
  export GIT_AUTHOR_NAME="unexist"
  export GIT_AUTHOR_EMAIL="unexist@dorfelite.net"
  export GIT_COMMITTER_NAME="unexist"
  export GIT_COMMITTER_EMAIL="unexist@dorfelite.net"
fi

# Browser
export BROWSER="/usr/bin/chromium-browser"

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

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
