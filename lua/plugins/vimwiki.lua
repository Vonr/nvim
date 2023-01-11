return {
    'vimwiki/vimwiki',
    cmd = {
        'VimwikiIndex',
        'VimwikiDiaryIndex',
        'VimwikiTabIndex',
        'VimwikiUISelect',
    },
    init = function()
        vim.g.vimwiki_table_mappings = 0
        vim.api.nvim_set_keymap('n', '<leader>ww', '<cmd>VimwikiIndex<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>w<leader>w', '<cmd>VimwikiDiaryIndex<CR>', { noremap = true, silent = true })
    end,
}
