local linters_by_ft = {
    markdown = { 'vale' },
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    bash = { 'shellcheck' },
}

return {
    'mfussenegger/nvim-lint',
    ft = (function()
        local fts = {}

        for ft, _ in pairs(linters_by_ft) do
            table.insert(fts, ft)
        end

        return fts
    end)(),
    config = function()
        require('lint').linters_by_ft = linters_by_ft
    end
}
