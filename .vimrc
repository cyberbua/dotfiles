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

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
map <space> /
"""""""""""

""""""""""""
" spelling "
""""""""""""
set spellfile=~/.vim/spell/custom.utf-8.add
set spelllang=de,en
set complete+=kspell
autocmd FileType latex,tex,md,markdown setlocal spell 
syn match CamelCase '\v(<\u\i*>)+' contains=@NoSpell
""""""""""""

"disable the damn arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

"""""""""
" Theme "
"""""""""
syntax on
colorscheme kalisi
set background=light
