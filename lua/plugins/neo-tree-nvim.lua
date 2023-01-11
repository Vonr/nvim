return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v2.x",
    cmd = {
        "NeoTreeClose",
        "NeoTreeFloat",
        "NeoTreeFloatToggle",
        "NeoTreeFocus",
        "NeoTreeFocusToggle",
        "NeoTreeLogs",
        "NeoTreePasteConfig",
        "NeoTreeReveal",
        "NeoTreeRevealInSplit",
        "NeoTreeRevealInSplitToggle",
        "NeoTreeRevealToggle",
        "NeoTreeSetLogLevel",
        "NeoTreeShow",
        "NeoTreeShowInSplit",
        "NeoTreeShowInSplitToggle",
        "NeoTreeShowToggle",
    },
    init = function()
        vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>NeoTreeFloatToggle<CR>', { noremap = true, silent = true })
    end,
}
