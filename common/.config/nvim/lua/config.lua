
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
      find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git"}
    },
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-r>', builtin.treesitter, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})


vim.g.gruvbox_baby_transparent_mode = true
vim.g.gruvbox_baby_background_color = dark
vim.g.gruvbox_baby_use_original_palette = false
-- vim.g.gruvbox_baby_telescope_theme = 1
--vim.cmd[[colorscheme gruvbox-baby]]
