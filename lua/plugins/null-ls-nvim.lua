return {
    'jose-elias-alvarez/null-ls.nvim',
    lazy = true,
    config = function()
        require'plugins/lspconfig/null-ls'
    end,
}
