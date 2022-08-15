vim.api.nvim_set_keymap('i', '<C-c>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-p>', '<cmd>Copilot panel<CR>', { silent = true })

vim.g.copilot_no_tab_map = true
