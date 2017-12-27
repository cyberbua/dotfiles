"""""""""""
" Options "
"""""""""""
set ignorecase smartcase
set number
set wrap
set linebreak
set hlsearch
set incsearch
set scrolloff=8
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
set mouse=
set timeoutlen=1000 ttimeoutlen=0
set clipboard=unnamedplus
set showtabline=2
set laststatus=2
set cursorline
set t_ut=   " fix background not redrawing
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,preview
set diffopt=filler,vertical
set virtualedit=block
set lazyredraw
set nostartofline
set showcmd
set pumheight=15
set synmaxcol=2048
set noshowmode

" keep indentation on linebreaks
let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr

" autoread on file change
set autoread
au CursorHold,CursorHoldI,InsertEnter * checktime

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" only hide buffer when switching
set hidden

" preview for s/foo/bar
if exists('&inccommand')
    set inccommand=nosplit
endif

set list listchars=trail:•,tab:\|\ ,
"""""""""""

""""""""""""
" Mappings "
""""""""""""
" comma as leader
let mapleader=" "

" disable the damn arrow keys
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

" buffer navigation
noremap <C-l> :bnext<CR>
noremap <C-h> :bprevious<CR>
noremap <Tab> :b#<CR>

" search using space
map <space> /

" Q to run the q macro
noremap Q @q

" Clear highlighting on escape in normal mode
nnoremap <silent> <esc> :nohlsearch<return><esc>
nnoremap <esc>^[ <esc>^[

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Y to yank without <cr> (thats what yy is for)
nnoremap Y y$

" save/quit
nnoremap <C-s>  :update<cr>
inoremap <C-s> <ESC>:update<cr>

function! s:closeorquit()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
        bdelete
    else
        quit
    endif
endfunc
nnoremap <silent> <C-Q> :call <sid>closeorquit()<CR>

" don't yank to default clipboard
noremap x "xx
noremap c "cc
nnoremap C "cC

" don't override register when pasting over something
vnoremap p "_dP

" keep visual selection when shifting
xnoremap < <gv
xnoremap > >gv

" Make . work with visually selected lines
xnoremap . :norm.<CR>

" window movement
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" indent everything
nnoremap <leader>i migg=G`i

if has('nvim')
    " window movement in terminal
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    " terminal split with <A-^>
    nnoremap <A-^> :above 20sp term://$SHELL<cr>i
    " exit terminal insert mode with <A-e> 
    tnoremap <A-e> <C-\><C-n>
    " close terminal when shell exits
    autocmd TermClose *:$SHELL,*:\$SHELL call feedkeys("\<CR>:\<BS>")
endif
"""""""""""""

"""""""""""
" Plugins "
"""""""""""
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'

Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'rakr/vim-one'

" show git diff in gutter
Plug 'airblade/vim-gitgutter'

" move lines with <C-k>/<C-j>
Plug 'matze/vim-move'
let g:move_key_modifier = 'C'

" linter
Plug 'w0rp/ale'
let g:ale_sign_error = '✹'
let g:ale_sign_warning = '✹'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

Plug 'scrooloose/nerdtree'
map <leader>n :NERDTreeToggle<CR>

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" language support collection
Plug 'sheerun/vim-polyglot'

" fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
nmap <leader>ff :Files<CR>
nmap <leader>fg :GFiles<CR>
nmap <leader>fl :Lines<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>fc :Commands<CR>
nmap <leader>fh :History:<CR>

" colorize rgb hex codes
Plug 'lilydjwg/colorizer'
let g:colorizer_maxlines = 500
function! s:togglecolorizer()
    if g:colorizer_maxlines <= line('$')
        let g:colorizer_maxlines = 20000
    elseif g:colorizer_maxlines >= line('$')
        let g:colorizer_maxlines = 1
    endif
    edit
endfunc
nmap <leader>c :call <sid>togglecolorizer()<CR>

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#sources = {}
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<C-l>"
Plug 'honza/vim-snippets'

Plug 'ryanoasis/vim-devicons'

" built in dictionary and synonym lookup
Plug 'beloglazov/vim-online-thesaurus'
let g:online_thesaurus_map_keys = 0
nnoremap <leader>d :OnlineThesaurusCurrentWord<CR>

" extend vim's text objects
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'

call plug#end()
"""""""""""

"""""""""
" Theme "
"""""""""
if has("nvim")
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if has("termguicolors")
    set termguicolors
    set t_8b=[48;2;%lu;%lu;%lum
    set t_8f=[38;2;%lu;%lu;%lum
endif

syntax on
set background=dark
colorscheme one

highlight CursorLine cterm=none term=none ctermbg=16 guibg=#2C323C
highlight IncSearch ctermfg=232 ctermbg=166 guibg=#000000 guifg=#df5f00
highlight Pmenu ctermfg=0 ctermbg=16 guibg=#31363f
highlight PmenuSel ctermfg=242 ctermbg=17 gui=bold guibg=#3e4452
highlight ALEWarning gui=bold,underline guifg=#e06c75
"""""""""

""""""""""""
" spelling "
""""""""""""
set spellfile=~/.config/nvim/spell/custom.utf-8.add
set spelllang=de,en
set complete+=kspell
autocmd FileType latex,tex,plaintex,md,markdown,gitcommit setlocal spell

" dont check acronyms | single char words | words with numbers
autocmd FileType latex,tex,plaintex,md,markdown,gitcommit syn match NoSpell '\<\S\+\u\+\S*\>\|\<\S\>\|\<\S*\d\+\S*\>' contains=@NoSpell
""""""""""""
