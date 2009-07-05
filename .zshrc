#
# @file Zsh profile
#
# @copyright (c) 2006-2009, Christoph Kappel <unexist@dorfelite.net>
# @version $Id$
#

# Colors
export ZLS_COLORS=`dircolors | sed s/LS/ZLS/ | head -n 1`

# Modules
autoload complist
autoload -U compinit
autoload edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

compinit

# Options
setopt correct
setopt hist_ignore_all_dups
setopt autocd
setopt extended_glob
setopt append_history
setopt auto_resume
setopt auto_continue
setopt multios
setopt short_loops
setopt listpacked
setopt completeinword

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000

# Style
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' 

# Keys
bindkey '^f' forward-word
bindkey '^b' backward-word

bindkey "\e[1~" beginning-of-line
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[3~" delete-char

# Prompt
if [ "$USER" = "root" ] ; then
  PS1='%m:%(1j.%%%j:.)%1~%# '
else
  PS1='%m:%(1j.%%%j:.)%1~%%%  '
fi

umask 022

# Man search order
export MANSECT="2:3:3p:1:1p:8:4:5:6:7:9:0p:tcl:n:l:p:o:1x:2x:3x:4x:5x:6x:7x:8x"

# Extending the path var
if [ -e $HOME/bin ] ; then
	export PATH=$HOME/bin:$PATH
fi

# Colorwrapper
if [ -e $HOME/.cw ] ; then
  export PATH=$HOME/.cw/def:$PATH
fi

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
  if [ -f $HOME/.keychain/$HOST-sh ] ; then
    source $HOME/.keychain/$HOST-sh
  fi
fi
