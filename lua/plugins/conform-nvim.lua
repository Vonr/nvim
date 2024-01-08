local formatters = {
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    dart = { 'dart_format' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
}

local disabled = {
    'haskell-tools.nvim',
    'tsserver',
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
                filter = function(client)
                    for _, name in ipairs(disabled) do
                        if name == client.name then
                            return false
                        end
                    end

                    return true
                end
            },
        })
    end
}
