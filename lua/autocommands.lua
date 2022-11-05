vim.api.nvim_create_autocmd({'BufEnter'},{
    pattern = { '*.css', '*.js', '*.html' },
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
    end
})

