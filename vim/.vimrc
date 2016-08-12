set nocompatible              " be iMproved, required
filetype off                  " required

" -----------------------8<-------------------------8<------------------------ "
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'chriskempson/base16-vim'
Plugin 'majutsushi/tagbar'
Plugin 'nfvs/vim-perforce'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" -----------------------8<-------------------------8<------------------------ "

set number             " Show line numbers
syntax on              " Enable syntax highlighting
set mouse=a            " Enable mouse support in all modes
set colorcolumn=80,120 " Show ruler at 80 and 120 columns

" The last semicolon is the key here. Keep going up the directory hierarchy when
" looking for the tags file
"set tags=./tags,./TAGS,tags,TAGS;
set tags=./tags;

" Colours/themes settings
set t_Co=256
"let base16colorspace=256
"set background=dark
"colorscheme base16-default-dark

" VimAirline settings
set laststatus=2 " Make it visible all the time
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_default'
let g:airline#extensions#tabline#enabled = 1 " Show list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" Ctrlp settings
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'top,ttb'
let g:ctrlp_open_new_file = 't'

" The Silver Searcher
"if executable('ag')
" " Use ag over grep
"  set grepprg=ag\ --nogroup\ --nocolor
"
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
"  let g:ctrlp_use_caching = 0
"endif
