return {
    'simrat39/rust-tools.nvim',
    lazy = true,
    config = function()
        require('plugins/lspconfig/rust')
    end,
}
