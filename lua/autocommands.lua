vim.api.nvim_create_autocmd({'BufEnter'},{
    pattern = { '*' },
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true
    end
})

vim.api.nvim_create_augroup('AlphaLoad', {})
vim.api.nvim_create_autocmd({'BufEnter'},{
    group = 'AlphaLoad',
    callback = function()
        if vim.fn.expand('%') == '' then
            vim.cmd'PackerLoad alpha-nvim'
        end
        vim.api.nvim_clear_autocmds({ group = 'AlphaLoad' })
    end
})

