return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = false,
    config = function()
        require('ibl').setup({
            scope = { enabled = false },
            indent = { char = '⎸', priority = 0 },
        })
    end,
    dependencies = {
        ({
            gruvbox = 'mhdahmad/gruvbox.lua',
            kanagawa = 'rebelot/kanagawa.nvim'
        })[vim.g.colors_name],
    }
}
