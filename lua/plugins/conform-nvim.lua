local formatters = {
    javascript = { { 'prettierd', 'prettier' } },
    typescript = { { 'prettierd', 'prettier' } },
    dart = { 'dart_format' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
}

return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function()
        require("conform").setup({
            formatters_by_ft = formatters,
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
        })
    end
}
