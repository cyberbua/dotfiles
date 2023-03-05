-- line breaks
vim.opt.linebreak = true                -- break long lines at breakat-chars
vim.opt.breakindent = true              -- maintain indent when breaking lines
vim.opt.showbreak = '↳ '                -- symbol to show for line breaks
vim.opt.breakindentopt = 'sbr'          -- showbreak symbol, then indent

-- indentation
vim.opt.tabstop = 4                     -- width of a tab
vim.opt.shiftwidth = 4                  -- number of spaces for >> or <<
vim.opt.softtabstop = 4                 -- <Tab> inserts spaces
vim.opt.expandtab = true                -- same as softtabstop, but different
vim.opt.autoindent = true               -- copy indentation for new lines

-- search & replace
vim.opt.ignorecase = true               -- ignore case when searching
vim.opt.smartcase = true                -- except searches containing upper case

-- misc
vim.opt.number = true                   -- show line numbers
vim.opt.relativenumber = true           -- relative numbers for efficient movement
vim.opt.scrolloff = 8                   -- maintain lines below/above cursor
vim.opt.pumheight = 15                  -- max size of completion menu
vim.opt.wildmode = 'longest:full,full'  -- complete to longest match first
vim.opt.virtualedit = 'block'           -- allow visual block in empty space
vim.opt.cursorline = true               -- highlight the line where the cursor is
vim.opt.foldmethod = 'marker'           -- fold at {{{ }}}
vim.opt.autoread = true                 -- re-read file when changed externally
vim.opt.splitbelow = true               -- create window-splits below
vim.opt.splitright = true               -- create window-splits on the right
vim.opt.list = true                     -- show certain whitespace characters
vim.opt.listchars:append{trail = '•', tab = '| '}   -- show tabs and trailing spaces

vim.opt.mousemodel = 'extend'           -- right mouse button extends selection
vim.opt.mouse = 'a'                     -- enable mouse in all modes

-- spell
vim.opt.spellfile = '~/.config/nvim/spell/custom.utf-8.add'
vim.opt.spelllang = 'de,en'
vim.opt.complete:append('kspell')


-- mappings
vim.g.mapleader = " "

-- helper function for setting keymaps with default values
function map(mode, lhs, rhs, opts)
    local defaults = {
        silent = true,
    }
    if opts then
        defaults = vim.tbl_extend("force", defaults, opts)
    end
    vim.keymap.set(mode, lhs, rhs, defaults)
end

-- move around wrapped lines easily
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- indent visual selections
map('x', '>', '>gv', opts)
map('x', '<', '<gv', opts)

-- use . on multiple line
map('x', '.', ':norm .<cr>', opts)

-- visual selection -> primary clipboard
map('x', '<LeftRelease>', '"*ygv', opts)

-- use <leader> + yank/paste for secondary clipboard
map('', '<leader>y', '"+y', {desc = 'yank to system clipboard'})
map('', '<leader>p', '"+p', {desc = 'paste from system clipboard'})
map('', '<leader>P', '"+P', {desc = 'Paste from system clipboard'})

-- move between buffers
map('n', '<c-l>', ':bnext<cr>', opts)
map('n', '<c-h>', ':bprevious<cr>', opts)
map('n', '<tab>', ':b#<cr>', opts)

-- save with ctrl-s
map('n', '<c-s>', ':update<cr>', opts)
map('i', '<c-s>', '<esc>:update<cr>', opts)

-- remove search highlighting with <esc>
map('n', '<esc>', ':nohlsearch<return><esc>', opts)

vim.cmd([[
function! s:closeorquit()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
        bdelete
    else
        quit
    endif
endfunc
nnoremap <silent> <C-Q> :call <sid>closeorquit()<CR>
]])

-- autocmds
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'md','markdown','latex','tex','gitcommit','plaintex'},
    callback = function()
        vim.cmd.setlocal('spell')
    end
})

-- plugin manager
-- install with these commands:
-- git clone --filter=blob:none "https://github.com/folke/lazy.nvim.git" --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
-- git -C ~/.local/share/nvim/lazy/lazy.nvim checkout $(jq -r '."lazy.nvim".commit' ~/.config/nvim/lazy-lock.json)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if vim.loop.fs_stat(lazypath) then
    vim.opt.runtimepath:prepend(lazypath)
    require('plugins')
else
    vim.cmd.colorscheme('habamax')
end
