return {
    'jose-elias-alvarez/null-ls.nvim',
    ft = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
    config = function()
        require'plugins/lspconfig/null-ls'
    end,
    dependencies = {
        'neovim/nvim-lspconfig',
    }
}
