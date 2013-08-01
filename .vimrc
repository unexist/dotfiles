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
set cursorline
set list!
set listchars=trail:-,tab:>-,eol:¬,nbsp:%,extends:>,precedes:<
set dy+=lastline
set dy+=uhex
set t_Co=256
set vb
"set spell spelllang=de_DE

syntax on

" Colorscheme
colorscheme xoria256

" Commandline
if has("cmdline_info")
  set ruler
  set showcmd
endif

" Functions
function! ToggleCopy()
  if exists("&number")
    set number!
    set listchars=
  else
    set number
    set listchars=trail:-,tab:>-,eol:<,nbsp:%,extends:>,precedes:< 
    syntax sync fromstart
  endif
endfunction

" Maps
map <F2> <Esc>:browse confirm e<CR>
map <F3> <Esc>:NERDTreeToggle<CR>
map <F7> <Esc>:setlocal spell! spelllang=de<CR>
map <F8> <Esc>:call ToggleCopy()<CR>
map <F9> <ESC>:so $VIMRUNTIME/syntax/hitest.vim<CR>
map <F6> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
map <F10> :TagbarToggle<CR>
map <F11> <Esc>:syntax sync fromstart<CR>

" Qname
let g:qname_hotkey = "<F4>"

" Nopaste
nnoremap <F12> :set invpaste paste?<CR>
imap <F12> <C-O><F12>
set pastetoggle=<F12>

" Move split
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>


" Brackets
"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Tab><Esc>O
"inoremap {{     {
"inoremap {}     {}

" Commands
command W w !sudo tee % /dev/null

" Filetype
if has("autocmd")
  filetype plugin on
  filetype indent off
endif

" Match
match ErrorMsg '\%>80v.\+'

" Line numbering
":au InsertEnter * :set number
":au InsertLeave * :set relativenumber
