-- vim: set tabstop=2 shiftwidth=2 softtabstop=2:
require("lazy").setup({
  {
    "navarasu/onedark.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    init = function()
      require('onedark').load()
      vim.cmd("highlight SpellBad gui=undercurl guifg=reset")
      vim.cmd("highlight SpellCap gui=undercurl guifg=reset")
      vim.cmd("highlight SpellRare gui=undercurl guifg=reset")
      vim.cmd("highlight SpellLocal gui=undercurl guifg=reset")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    opts = {
      signcolumn = true
    }
  },

  {
    "folke/which-key.nvim",
    enabled = true,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        plugins = {
          spelling = false
        },
        operators = { gc = "Comments" },  -- does thi do anything?
      })
    end,
  },

  {
    'echasnovski/mini.comment',
    enabled = true,
    config = function()
      require("mini.comment").setup()
    end
  },

  {
    "windwp/nvim-autopairs",
    enabled = true,
    config = function()
      require("nvim-autopairs").setup({ })
    end

  },

  {
    "kylechui/nvim-surround",
    enabled = true,
    config = function()
      require("nvim-surround").setup({ })
    end

  },

  {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
          globalstatus = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'%B', 'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'%l/%L:%3v'}
        },
        tabline = {
          lualine_b = {'buffers'},
          lualine_y = {'tabs'}
        },
      })
    end
  },

  {
    'ibhagwan/fzf-lua',
    enabled = true,
    config = function()
      require("nvim-surround").setup({ })
      map('n', '<leader>F', ':FzfLua resume<cr>', {desc = 'FZF resume last query'})
      map('n', '<leader>ff', ':FzfLua files<cr>', {desc = 'FZF files in PWD'})
      map('n', '<leader>fg', ':FzfLua git_files<cr>', {desc = 'FZF files in git'})
      map('n', '<leader>fb', ':FzfLua buffers<cr>', {desc = 'FZF buffers'})
      map('n', '<leader>fl', ':FzfLua lines<cr>', {desc = 'FZF lines in open buffers'})
      map('n', '<leader>fL', ':FzfLua blines<cr>', {desc = 'FZF lines current buffer'})
      map('n', '<leader>fh', ':FzfLua help_tags<cr>', {desc = 'FZF help tags'})
      map('n', '<leader>fm', ':FzfLua man_pages<cr>', {desc = 'FZF man pages'})
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    build = ':TSUpdate',
    config = function()
      function fun_disable(lang, buf)
        local max_filesize = 1000 * 1024 -- 1000 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end
      require("nvim-treesitter.configs").setup({
        ensure_installed = {'bash', 'bibtex', 'c', 'cpp', 'css', 'diff', 'gitcommit', 'go', 'help', 'html', 'ini', 'java', 'javascript', 'json', 'json5', 'jsonc', 'latex', 'make', 'markdown', 'markdown_inline', 'perl', 'php', 'python', 'regex', 'rust', 'smali', 'toml', 'typescript', 'vim', 'yaml'},
        highlight = {
          enable = true,
          disable = fun_disable
        },
        incremental_selection = {
          enable = true,
          disable = fun_disable,
          keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            scope_incremental = "<tab>",
            node_decremental = "<s-tab>",
          },
        },
      })
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-refactor",
    enabled = true,
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
      vim.opt.updatetime = 1000   -- used for highlight_definitions
      vim.cmd("highlight TSDefinitionUsage cterm=underline guibg=#2c5372")
      require("nvim-treesitter.configs").setup({
        refactor = {
          highlight_definitions = {
            enable = true,
            disable = fun_disable
          },
          smart_rename = {
            enable = true,
            disable = fun_disable,
            keymaps = {
              smart_rename = "<leader>r"
            },
          }
        },
      })
    end
  }

})

