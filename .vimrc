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
set ch=1
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
set nobackup
set noswapfile

syntax on
colorscheme merged

" Nopaste
nnoremap <F12> :set invpaste paste?<CR>
imap <F12> <C-O><F12>
set pastetoggle=<F12>

" Commandline
if has("cmdline_info")
  set ruler
  set showcmd
endif

" Maps
map <F2> :browse confirm e<CR>
map <F3> :NERDTreeToggle<CR>
map <F5> :FuzzyFinderBuffer<CR>

" Gui
if has("gui_running")
  set guioptions=a
  set guifont=lucidatypewriter\ 10
endif

" Filetype
if has("autocmd")
  filetype plugin on
  filetype indent off
endif
