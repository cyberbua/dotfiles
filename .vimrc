"""""""""""
" Options "
"""""""""""
set ignorecase
set smartcase
set nu
set tabstop=4
set wrap
set linebreak
set hlsearch
set incsearch
set so=7
set autoindent
set shiftwidth=4
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
set timeoutlen=1000 ttimeoutlen=0
set clipboard=unnamedplus
set showtabline=2
"""""""""""

"""""""""""
" Plugins "
"""""""""""
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'rakr/vim-one'

call plug#end()
"""""""""""

"""""""""
" Theme "
"""""""""
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

syntax on
set background=dark
colorscheme one
set termguicolors
"""""""""

""""""""""""
" spelling "
""""""""""""
set spellfile=~/.vim/spell/custom.utf-8.add
set spelllang=de,en
set complete+=kspell
autocmd FileType latex,tex,md,markdown setlocal spell 

" dont check acronyms | single char words | words with numbers
autocmd FileType latex,tex,md,markdown syn match NoSpell '\<\S\+\u\+\S*\>\|\<\S\>\|\<\S*\d\+\S*\>' contains=@NoSpell
""""""""""""

""""""""""""
" Mappings "
""""""""""""
" comma as leader
let mapleader=","

"disable the damn arrow keys
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

" tab navigation
noremap <C-h> gT
noremap <C-l> gt

" search using space
map <space> /

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" move in insert mode
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk
inoremap <C-l> <C-o>a
""""""""""""
