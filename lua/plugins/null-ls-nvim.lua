return {
    'jose-elias-alvarez/null-ls.nvim',
    enabled = false, -- Deprecated
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
        "dart",
        "python",
    },
    config = function()
        local nls = require'null-ls'
        local fmt = nls.builtins.formatting

        nls.setup({
            sources = {
                fmt.clang_format.with {
                    filetypes = { "cpp", "c" },
                },
                fmt.dart_format,
            },
        })
    end,
    dependencies = {
        'neovim/nvim-lspconfig',
    }
}
