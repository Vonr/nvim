local tab_widths = {
    haskell = 2
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function(ev)
        vim.bo.tabstop = 4
        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true

        for ft, w in pairs(tab_widths) do
            if ft == ev.match then
                vim.bo.tabstop = w
                vim.bo.softtabstop = w
                vim.bo.shiftwidth = w
            end
        end
    end
})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'Makefile',
    callback = function()
        vim.bo.expandtab = false
    end
})
