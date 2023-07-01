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
        "dart",
        "python",
    },
    config = function()
        local nls = require'null-ls'
        local fmt = nls.builtins.formatting
        local dia = nls.builtins.diagnostics
        local hov = nls.builtins.hover
        local cax = nls.builtins.code_actions
        local cmp = nls.builtins.completion

        nls.setup({
            sources = {
                dia.eslint_d,
                dia.mypy,
                dia.shellcheck.with({
                    diagnostics_format = "[#{c}] #{m} (#{s})"
                }),

                fmt.clang_format.with {
                    filetypes = { "cpp", "c" },
                },
                fmt.dart_format,

                cax.shellcheck,
            },
        })
    end,
    dependencies = {
        'neovim/nvim-lspconfig',
    }
}
