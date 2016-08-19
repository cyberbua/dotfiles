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
"syn match CamelCase '\v(<\u\i*>)+' contains=@NoSpell
""""""""""""

""""""""""""
" Mappings "
""""""""""""
"disable the damn arrow keys
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

noremap <C-h> gT
noremap <C-l> gt
""""""""""""

"""""""""
" Theme "
"""""""""
syntax on
colorscheme kalisi
set background=light

hi TabLineFill cterm=none ctermfg=white ctermbg=lightgrey
hi TabLine     cterm=none ctermfg=white ctermbg=grey
hi TabLineSel  cterm=none ctermfg=white ctermbg=darkgrey

"""""""""""
" Plugins "
"""""""""""
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

Plug 'terryma/vim-multiple-cursors'

call plug#end()
"""""""""""
