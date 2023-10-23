local linters_by_ft = {
    markdown = { 'vale' },
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    bash = { 'shellcheck' },
}

local fts = {}

for ft, _ in pairs(linters_by_ft) do
    table.insert(fts, ft)
end

return {
    'mfussenegger/nvim-lint',
    ft = fts,
    config = function()
        require('lint').linters_by_ft = linters_by_ft
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
