"
" @file Vim config
"
" @copyright (c) 2008-2010, Christoph Kappel <unexist@dorfelite.net>
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
set autowriteall
set noswapfile
set list!
set listchars=trail:-,tab:>-,eol:<,nbsp:%,extends:>,precedes:<
set dy+=lastline
set dy+=uhex

syntax on

" Colorscheme
colorscheme digerati

" Commandline
if has("cmdline_info")
  set ruler
  set showcmd
endif

" Maps
map <F2> <Esc>:browse confirm e<CR>
map <F3> <Esc>:NERDTreeToggle<CR>
map <F9> <ESC>:so $VIMRUNTIME/syntax/hitest.vim<CR>
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
map <F11> <Esc>:syntax sync fromstart<CR>

" Qname
let g:qname_hotkey = "<F4>"

" Nopaste
nnoremap <F12> :set invpaste paste?<CR>
imap <F12> <C-O><F12>
set pastetoggle=<F12>

" Filetype
if has("autocmd")
  filetype plugin on
  filetype indent off
endif

" Match
match ErrorMsg '\%>80v.\+'
