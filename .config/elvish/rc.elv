#
# @file Elvish profile
#
# @copyright (c) 2024-present, Christoph Kappel <christoph@unexist.dev>
# @version $Id$
#

use str
use path
use unix
use re

# Defaults and environment
set E:EDITOR = /usr/bin/vim
set E:BROWSER = /usr/bin/brave-browser
set E:MANSECT = "2:3:3p:1:1p:8:4:5:6:7:9:0p:tcl:n:l:p:o:1x:2x:3x:4x:5x:6x:7x:8x"

# XDG directories
set E:XDG_DESKTOP_DIR = $E:HOME
set E:XDG_DOWNLOAD_DIR = $E:HOME/downloads
set E:XDG_TEMPLATES_DIR = $E:HOME
set E:XDG_PUBLICSHARE_DIR = $E:HOME
set E:XDG_DOCUMENTS_DIR = $E:HOME/documents
set E:XDG_MUSIC_DIR = $E:HOME/downloads
set E:XDG_PICTURES_DIR = $E:HOME/images
set E:XDG_VIDEOS_DIR = $E:HOME/downloads

# Update paths
var appendIfExists = { |paths, newPath|
    if ?(test -d newPath) {
        echo (conj $paths $newPath)
    } else {
        echo $paths
    }
}

var paths = $E:PATH

set paths = ($appendIfExists $paths, "$E:HOME/bin")
set paths = ($appendIfExists $paths, "$E:HOME/.config/bin")
set paths = ($appendIfExists $paths, "/usr/local/bin")
set paths = ($appendIfExists $paths, "$E:HOME/.cargo/bin")
set paths = ($appendIfExists $paths, "$E:HOME/applications/go/bin")
set paths = ($appendIfExists $paths, "$E:HOME/applications/zig")
set paths = ($appendIfExists $paths, "$E:HOME/applications/spark-3.5.1-bin-hadoop3/bin")

# ls
fn ls { |@args| e:lsd --color=auto --group-directories-first --human-readable -v $@args }
fn la { |@args| ls -a $@args }
fn l { |@args| ls -l $@args }

# Miscellaneous
fn q { clear; logout }
fn .. { cd .. }
fn ... { cd ../.. }
fn .... { cd ../../.. }

# Security
fn cp { |@args| e:cp -i $@args }
fn mv { |@args| e:mv -i $@args }
fn rm { |@args| e:rm -i $@args }

# sudo
if (has-external sudo) {
    fn s { sudo }

    if (has-external pacman) {
        fn p { |@args| packer --noedit $@args }
        fn I { |@args| e:sudo pacman -S $@args }
        fn R { |@args| e:sudo pacman -R $@args }
        fn S { |@args| pacman -Q $@args }
    } elif (has-external apt-get) {
        fn p { |@args| e:sudo apt-get $@args }
        fn I { |@args| e:sudo apt-get install $@args }
        fn R { |@args| e:sudo apt-get remove $@args }
        fn S { |@args| apt-cache search $@args }
    }
}

# Concalc
if (has-external concalc) {
    fn calc { |@args| concalc $@args }
}

# Mercurial
if (has-external hg) {
    fn hgs { hg status -X unknown }
    fn hgp { hg push }

    if (has-external fzf) {
        fn hgd { hg diff (hg status -X unknown | fzf --tac --no-sort | cut -d ' ' -f2 | xargs | slurp) }
        fn hgc { hg ci (hg status -X unknown | fzf --multi --tac --no-sort | cut -d ' ' -f2 | xargs | slurp) }
    }
}

# zoxide
if (has-external zoxide) {
    #eval (zoxide init elvish)
}

# Prompt
set edit:prompt = {
    # Abbreviate path by shortening the parent directories
    styled (re:replace '([^/])[^/]*/' '$1/' (tilde-abbr $pwd)) bold
    if (not-eq $E:SSH_CLIENT "") {
        styled " "(cat /etc/hostname)" " "white;bg-red;bold"
    }
    styled "  " blue bold
}
set edit:rprompt = { }

# Umask
set unix:umask = 22
