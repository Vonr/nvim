local nls = require'null-ls'
nls.setup({
    sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.diagnostics.eslint,
        nls.builtins.completion.spell,
        nls.builtins.diagnostics.shellcheck.with({
            diagnostics_format = "[#{c}] #{m} (#{s})"
        }),
    },
})
