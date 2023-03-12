vim.api.nvim_create_autocmd({'BufEnter'},{
    pattern = { '*' },
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true
    end
})

vim.api.nvim_create_autocmd({'BufEnter'},{
    pattern = { 'Makefile' },
    callback = function()
        vim.bo.expandtab = false
    end
})
