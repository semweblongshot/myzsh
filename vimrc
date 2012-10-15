" gotta start things off right
set nocompatible

call pathogen#infect()

filetype on
filetype plugin on
filetype indent on

set encoding=utf-8 nobomb
set termencoding=utf-8
set fileformat=unix 

" change the mapleader from \ to ,
let mapleader=","

" ,v brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

set wildmode=longest:full
set wildmenu

set autowrite
set autoread
set autoindent
set showcmd
set ruler
set ch=2
set ls=2
set hidden
set showmatch
set foldenable
set backspace=indent,eol,start
set ignorecase
set smartindent
set nowrap
set scrolloff=2
set tabstop=2
set smarttab
set expandtab
set shiftwidth=2
set shiftround
set mousehide
set showmode
set hlsearch
set incsearch     
set history=2048
set undolevels=2048
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set number
set lazyredraw
set statusline=%F%m%r%h%w\ %{&ff}\ [ROW=%03l/%03L,COL=%03v,PCT=%p%%]\ [ASCII=\%03.3b/HEX=\%02.2B]\ %y

set background=dark
let g:Powerline_symbols = 'fancy'
set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline:h14

if &t_Co >= 256 || has("gui_running")
  colorscheme solarized
else
  colorscheme default
endif

syntax on
source ~/.vim/plugin/matchit.vim
set gfn=Bitsteam\ Vera\ Sans\ Mono\ 12

" try to auto set conf files to shell syntax
au! BufNewFile,BufRead */conf/* set filetype=sh
