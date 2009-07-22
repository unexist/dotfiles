"
" @file Vim config
"
" @copyright (c) 2008-2009, Christoph Kappel <unexist@dorfelite.net>
" @version $Id$
"

" Options
set nocompatible
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set noincsearch
set nowrap
set ts=2
set bs=2
set sw=2
set expandtab
set showmatch
set shortmess=aIT
set foldmethod=marker
set enc=utf-8
set autoindent
set nocindent
set number

syntax on
colorscheme mustang

" Maps
map <F3> :NERDTreeToggle<CR>
map <F5> :FuzzyFinderBuffer<CR>

" Gui
if has('gui_running')
  set guioptions=a
  set guifont=lucidatypewriter\ 10

  map <F2> :browse confirm e<CR>
endif

if has("autocmd")
  filetype plugin on
  filetype indent off

  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif
