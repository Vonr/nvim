return {
    'lewis6991/spaceless.nvim',
    event = 'InsertCharPre',
    config = function()
        require'spaceless'.setup()
    end,
}
