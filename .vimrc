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
set hlsearch
set nowrap
set ts=2
set bs=2
set sw=2
set scrolloff=2
set expandtab
set showmatch
set showmode
set shortmess=aIT
set foldmethod=marker
set encoding=utf-8
set autoindent
set nocindent
set number
set lazyredraw
set wildmode=list:longest,full
set wildignore=*.o,*.swp
set pastetoggle=<F12>
set nobackup

" Syntax
if has('syntax') && (&t_Co > 2 || has('gui_running'))
  syntax on
  colorscheme mustang
endif

" Commandline
if has('cmdline_info')
  set ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
  set showcmd
endif

" Statusline
if has('statusline')
  set laststatus=2
  set statusline=%<%f\ %=\:\b%n\[%{strlen(&ft)?&ft:'none'}/%{&encoding}/%{&fileformat}]%m%r%w\ %l,%c%V\ %P
endif

" Maps
map <F2> :browse confirm e<CR>
map <F3> :NERDTreeToggle<CR>
map <F5> :FuzzyFinderBuffer<CR>

" Gui
if has('gui_running')
  set guioptions=a
  set guifont=lucidatypewriter\ 10
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
