" gui config
syntax on
set number

set tabstop=2
set scrolloff=10
set nocompatible

" search config
set incsearch
set showmatch
set hlsearch
set ignorecase
set smartcase

" plugins
filetype on
filetype plugin on

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'preservim/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'lambdalisue/suda.vim'

call plug#end()

autocmd vimenter * ++nested colorscheme gruvbox

command! -nargs=0 Prettier :cal CocAction('runCommand', 'prettier.formatFile')

map <silent> <C-b> :NERDTreeToggle<CR>

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
cmap w!! :w suda://%