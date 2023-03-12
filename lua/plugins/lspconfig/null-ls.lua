local nls = require'null-ls'
nls.setup({
    sources = {
        nls.builtins.diagnostics.eslint,
        nls.builtins.diagnostics.mypy,
        nls.builtins.diagnostics.shellcheck.with({
            diagnostics_format = "[#{c}] #{m} (#{s})"
        }),
        nls.builtins.formatting.prettierd,
    },
})
