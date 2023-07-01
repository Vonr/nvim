return {
    'lervag/vimtex',
    ft = { 'tex' },
    config = function()
        vim.b.maplocalleader = ' '
        vim.g.vimtex_view_method = 'zathura'
    end
}
