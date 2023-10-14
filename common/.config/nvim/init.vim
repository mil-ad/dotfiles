set nocompatible              " be iMproved, required
filetype off                  " required

" -----------------------8<-------------------------8<------------------------ "
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'haya14busa/is.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'feline-nvim/feline.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
"Plug 'scrooloose/nerdtree'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}

call plug#end()
" -----------------------8<-------------------------8<------------------------ "

set number              " Show line numbers
set nowrap              " Do not wrap lines
syntax on               " Enable syntax highlighting
set mouse=a             " Enable mouse support in all modes
set colorcolumn=81,121  " Show ruler at 80(+1) and 120(+1) columns
set foldmethod=syntax   " Fold based on syntax
set foldlevelstart=99   " Unfold everything when opening a buffer
set cursorline          " Highlight current line
set showmatch           " show matching brackets
set encoding=UTF-8

set wildmenu            " Show possible options when doing tab-completion
" When more than one match in tab-complete, list all matches and complete
" until longest common string.
set wildmode=longest:full,full

set clipboard+=unnamedplus " Use system clipboard?

set ignorecase          " Ignore case when searching
set smartcase           " Override ignorecase when search pattern includes uppercase

set incsearch           " Search as you type
set hlsearch            " Highlight all search matches, use :nohlsearch to hide them

" Make sure whitespace character are displayed
set list
set listchars=space:·,tab:🡒\ ,nbsp:␣,extends:⟩,precedes:⟨

set tabstop=4
set shiftwidth=4

" The last semicolon is the key here. Keep going up the directory hierarchy when
" looking for the tags file
"set tags=./tags,./TAGS,tags,TAGS;
set tags=./tags;

" Colours/themes settings
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
"let base16colorspace=256

set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE	" Make the background transparent

" Key mappings
let mapleader=" " " Use spacekey as <Leader>
nnoremap <Leader><PageUp> :bprevious<CR>
nnoremap <Leader><PageDown> :bnext<CR>
nnoremap <Leader>t :enew<CR>
nnoremap <Leader>w :bdelete<CR>
nnoremap <Leader>r :CtrlPBufTag<CR>
nnoremap <Leader>/ :set hlsearch!<CR>
nnoremap <Leader>r :source $MYVIMRC<CR>
"nn <C-p> :Files<CR>
"nn <C-r> :BTags<CR>
nn <C-/> :NERDTreeToggle<CR>
map q <Nop>

" custom text-objects for /
onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
onoremap <silent> a/ :<C-U>normal! F/vf/<CR> " around /


" VimAirline settings
set laststatus=2 " Make it visible all the time
let g:airline_powerline_fonts = 1
"let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1 " Show list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'top,ttb'
let g:ctrlp_open_new_file = 't'

" Use the Silver Searcher when possible
" if executable('ag')
" " Use ag over grep
"  set grepprg=ag\ --nogroup\ --nocolor
"
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag %s -l -g ""'
"endif

command! -bar -bang Q quit<bang>

lua require('config')
