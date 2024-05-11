vim.o.relativenumber = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-Tab>', builtin.buffers, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-r>', builtin.treesitter, {})
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
