set nocompatible              " be iMproved, required
filetype off                  " required

" -----------------------8<-------------------------8<------------------------ "
" set the runtime path to include Vundle and initialize.
" Keep Plugin commands between vundle#begin/end.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins on GitHub 
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'craigemery/vim-autotag'
Plugin 'nfvs/vim-perforce'
Plugin 'junegunn/fzf.vim'
Plugin 'morhetz/gruvbox'

" The following are examples of different formats supported.

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" -----------------------8<-------------------------8<------------------------ "

set number             	" Show line numbers
set nowrap		" Do not wrap lines
syntax on              	" Enable syntax highlighting
set mouse=a            	" Enable mouse support in all modes
set colorcolumn=81,121 	" Show ruler at 80(+1) and 120(+1) columns
set foldmethod=syntax   " Fold based on syntax
set foldlevelstart=99   " Unfold everything when opening a buffer
set cursorline		" Highlight current line

set wildmenu		" Show possible options when doing tab-completion
" When more than one match in tab-complete, list all matches and complete till
" longest common string.
set wildmode=longest:full,full 

set ignorecase	       	" Ignore case when searching
set smartcase	       	" Override ignorecase when search pattern includes upper case

set incsearch		" Search as you type
set hlsearch 		" Highlight all search matches, use :nohlsearch to hide them

" The last semicolon is the key here. Keep going up the directory hierarchy when
" looking for the tags file
"set tags=./tags,./TAGS,tags,TAGS;
set tags=./tags;

" Colours/themes settings
set t_Co=256
"let base16colorspace=256
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox 

" Key mappings
let mapleader=" " " Use spacekey as <Leader>
nnoremap <Leader><PageUp>   :bprevious<CR>
nnoremap <Leader><PageDown> :bnext<CR>
nnoremap <Leader>t	    :enew<CR>
nnoremap <Leader>w	    :bdelete<CR>
nnoremap <Leader>r	    :CtrlPBufTag<CR>
nnoremap <Leader>/	    :set hlsearch!<CR> 
" VimAirline settings
set laststatus=2 " Make it visible all the time
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1 " Show list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" Ctrlp settings
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'top,ttb'
let g:ctrlp_open_new_file = 't'

" Tagbar settings
let g:tagbar_sort = 0	" Sort based on their order in the file

" Use the Silver Searcher when possible
" if executable('ag')
" " Use ag over grep
"  set grepprg=ag\ --nogroup\ --nocolor
"
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag %s -l -g ""'
"endif

set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND='ag -g ""'
