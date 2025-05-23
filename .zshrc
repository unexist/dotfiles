#
# @file Zsh profile
#
# @copyright (c) 2006-present, Christoph Kappel <christoph@unexist.dev>
# @version $Id$
#

# Colors
#export ZLS_COLORS=`dircolors | sed s/LS/ZLS/ | head -n 1`

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
#setopt ignore_eof

# History
export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=5000

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

# macOS
if [[ "x$OSTYPE" == "xdarwin"* ]] ; then
    bindkey "^[[~1" beginning-of-line
    bindkey "^[[~4" end-of-line

    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi

# Functions
function ansi-colors {
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

# Prompt
function prompt_status {
    if [[ $? == "0" ]]; then
        echo -e ""
    else
        echo -e "󰵙 "
    fi
}

if [ "$USER" = "root" ] ; then
    PS1=%1~$'%{\e[36;1m%}%(1j.%%%j.)%{\e[30;1m%} $(prompt_status) %{\e[0m%}'
else
    PS1=%1~$'%{\e[36;1m%}%(1j.%%%j.)%{\e[34;1m%} $(prompt_status) %{\e[0m%}'
fi

PS1=$'${(r:$COLUMNS::\u2500:)}'$PS1
#PS1=$'%{\e(0%}${(r:$COLUMNS::q:)}%{\e(B%}'$PS1
#PS1=$'${(r:$COLUMNS::-:)}'$PS1

umask 022

# Fix broken locales in arch
export LC_CTYPE="en_US.UTF-8"

# Man search order
export MANSECT="2:3:3p:1:1p:8:4:5:6:7:9:0p:tcl:n:l:p:o:1x:2x:3x:4x:5x:6x:7x:8x"

# Extending the path
if [ -e "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -e "/usr/local/bin" ] ; then
    export PATH="/usr/local/bin:$PATH"
fi

# Adding brew stuff
if [ -e "/usr/local/bin/brew" ] ; then
    export PATH="$(brew --prefix)/bin:$PATH"
fi

# Adding rust stuff
if [ -e "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Adding go stuff
if [ -e "$HOME/applications/go/bin" ] ; then
    export PATH="$HOME/applications/go/bin:$HOME/applications/go-packages/bin:$PATH"
    export GOROOT="$HOME/applications/go"
    export GOPATH="$HOME/applications/go-packages"
fi

# Adding zig stuff
if [ -e "$HOME/applications/zig" ] ; then
    export PATH="$HOME/applications/zig:$PATH"
fi

# Adding spark stuff
if [ -e "$HOME/applications/spark-3.5.1-bin-hadoop3" ] ; then
    export PATH="$HOME/applications/spark-3.5.1-bin-hadoop3/bin:$HOME/applications/spark-3.5.1-bin-hadoop3/sbin:$PATH"
fi

# Adding pipx stuff
if [ -e "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Setting default editor
if [ -f /usr/bin/vim ] ; then
    export EDITOR=/usr/bin/vim
fi

# Testcontainers
export TESTCONTAINERS_CHECKS_DISABLE=true
export TESTCONTAINERS_RYUK_DISABLED=true
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=unix://${HOME}/.local/share/containers/podman/machine/podman-machine-default/podman.sock

# fzf settings
command -v fzf &>/dev/null

if [ $? -eq 0 ]; then
    export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
fi

# XDG dirs
if [ -e "$HOME/.config/user-dirs.dirs" ] ; then
    source $HOME/.config/user-dirs.dirs
fi

# Browser
export BROWSER="/usr/bin/brave-browser"

# cups
export CUPS_USER='ad-ces\ckappel'

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
if [ -s "$HOME/.rvm/scripts/rvm" ] ; then
    source "$HOME/.rvm/scripts/rvm"

    # Add RVM to PATH for scripting
    PATH=$PATH:$HOME/.rvm/bin
fi

# JAVA
command -v java_home &>/dev/null

if [ $? -eq 0 ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
else
    export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which javac))))"
fi

# jenv
if [ -f "$HOME/.jenv//jenv.version" ] ; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# Kubectl
if [ -e "$HOME/.krew/bin" ] ; then
    export PATH="${PATH}:${HOME}/.krew/bin"
fi

# brew
command -v brew &>/dev/null

if [ $? -eq 0 ]; then
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

# zoxide
command -v zoxide &>/dev/null

if [ $? -eq 0 ]; then
    eval "$(zoxide init zsh)"
fi

# mcfly
command -v mcfly &>/dev/null

if [ $? -eq 0 ]; then
    eval "$(mcfly init zsh)"
fi



# Zsh vi mode
if [ -e ${HOME}/bin/zsh-vi-mode.zsh ] ; then
    source ${HOME}/bin/zsh-vi-mode.zsh
fi

