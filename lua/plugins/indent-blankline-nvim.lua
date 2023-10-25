return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        require('ibl').setup({
            scope = { enabled = false },
        })
    end,
    dependencies = {
        ({
            gruvbox = 'mhdahmad/gruvbox.lua',
            kanagawa = 'rebelot/kanagawa.nvim'
        })[vim.g.colors_name],
    }
}
