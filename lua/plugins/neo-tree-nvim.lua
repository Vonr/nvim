return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
    event = "BufEnter",
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
