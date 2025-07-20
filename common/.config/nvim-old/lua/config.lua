vim.o.relativenumber = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "bash", "lua", "javascript" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("telescope").setup {
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git"},
	  --"layout_strategy='horizontal'
    },
  },
  defaults = {
    layout_config = {
      horizontal = { height = 0.65 }
    },
  }
}

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

local commander = require("commander")

commander.setup({
  components = {
    "DESC"
  },
  integration = {
      telescope = {
          enable = true,
      }
  }
})

commander.add({
    {
        desc = "Toggle wrapping",
        cmd = "<CMD>set wrap!<CR>"
    },
    {
        desc = "Convert tabs to spaces",
        cmd = "<CMD>retab<CR>"
    },
  {
    desc = "Search inside current buffer",
    cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
    keys = { "n", "<leader>fl" },
  }, {
    -- You can specify multiple keys for the same cmd ...
    desc = "Show document symbols",
    cmd = "<CMD>Telescope lsp_document_symbols<CR>",
    keys = {
      {"n", "<leader>ss", { noremap = true } },
      {"n", "<leader>ssd", { noremap = true } },
    },
  }, {
    -- You can pass in a key sequences as if you would type them in nvim
    desc = "My favorite key sequence",
    cmd = "A  -- Add a comment at the end of a line",
    keys = {"n", "<leader>Ac" }
  }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-Tab>', builtin.buffers, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-r>', builtin.treesitter, {})
vim.keymap.set('n', '<leader>g', builtin.git_status, {})
vim.keymap.set('n', '<leader>p', ':Telescope commander<CR>', {})
vim.keymap.set('n', '<A-j>', ':m .+1<CR>', {})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>', {})

vim.g.gruvbox_baby_transparent_mode = true
vim.g.gruvbox_baby_background_color = dark
vim.g.gruvbox_baby_use_original_palette = false
-- vim.g.gruvbox_baby_telescope_theme = 1
--vim.cmd[[colorscheme gruvbox-baby]]

require('lualine').setup {
  options = {
    theme = 'gruvbox',
    globalstatus = true,
  }
}

require("toggleterm").setup { 
    open_mapping = [[<c-`>]],
}

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}

vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true
})

require("hlchunk").setup {
  chunk = {
    enable = true,
    use_treesitter = true,
    chars = {
      horizontal_line = "━",
      vertical_line = "┃",
      left_top = "┏",
      left_bottom = "┗",
      right_arrow = "━",
    },
  },
  blank = {
    enable = false,
  },
  line_num = {
    enable = true,
    use_treesitter = true,
  },
}

vim.opt.fillchars = {
    eob = " ", -- suppress ~ at EndOfBuffer
  }
