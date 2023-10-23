return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
    cmd = { 'Neotree' },
    keys = {
        { mode = 'n', '<Leader>n' }
    },
    init = function()
        vim.api.nvim_create_autocmd('BufEnter', {
            callback = function()
                if vim.fn.isdirectory(vim.fn.expand('%:p')) == 1 then
                    require('lazy').load({ plugins = {'neo-tree.nvim'} })
                    return true
                end
                return false
            end
        })
    end,
    config = function()
        vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>Neotree filesystem reveal float<CR>', { noremap = true, silent = true })

        require('neo-tree').setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                },
                hijack_netrw_behavior = 'open_current',
            },
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
}
