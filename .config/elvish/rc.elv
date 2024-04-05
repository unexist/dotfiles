#
# @file Elvish profile
#
# @copyright (c) 2024-present, Christoph Kappel <christoph@unexist.dev>
# @version $Id$
#

use str
use path
use unix

# Defaults and environment
set E:EDITOR = /usr/bin/vim
set E:BROWSER = /usr/bin/brave-browser

set E:PATH = (str:join : [~/bin ~/.config/bin $E:PATH])

# ls
fn ls {|@args| e:lsd --color=auto --group-directories-first --human-readable -v $@args }
fn la {|@args| ls -a $@args }
fn l {|@args| ls -l $@args }

# Miscellaneous
fn q { clear; logout }
fn .. { cd .. }
fn ... { cd ../.. }
fn .... { cd ../../.. }

# Security
fn cp {|@args| e:cp -i $@args }
fn mv {|@args| e:mv -i $@args }
fn rm {|@args| e:rm -i $@args }

# sudo



# Prompt
set edit:prompt = {
    use re
    # Abbreviate path by shortening the parent directories
    styled (re:replace '([^/])[^/]*/' '$1/' (tilde-abbr $pwd)) bold
    if (not-eq $E:SSH_CLIENT "") {
        styled " "(cat /etc/hostname)" " "white;bg-red;bold"
    }
    styled "  " blue bold
}
set edit:rprompt = { }

set unix:umask = 22
