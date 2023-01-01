
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "bash", "lua", "javascript" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-r>', builtin.treesitter, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
