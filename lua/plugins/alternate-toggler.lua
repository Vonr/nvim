return {
    'rmagatti/alternate-toggler',
    cmd = 'ToggleAlternate',
    init = function()
        vim.api.nvim_set_keymap('n', '<Leader><C-x>', '<cmd>ToggleAlternate<CR>', { noremap = true, silent = false })
    end,
}
