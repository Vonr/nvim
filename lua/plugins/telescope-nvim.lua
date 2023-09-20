return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    cmd = "Telescope",
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    n = {
                        q = actions.close,
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
                layout_config = {
                    horizontal = {
                        height = 0.9,
                        preview_cutoff = 20,
                        prompt_position = "bottom",
                        width = 0.8,
                    },
                }
            },
        })
    end,
    init = function()
        ---@diagnostic disable: duplicate-set-field
        vim.keymap.set('n', '//', function() require'telescope.builtin'.current_buffer_fuzzy_find() end, { noremap = true, silent = true})
        vim.keymap.set('n', '??', function() require'telescope.builtin'.live_grep() end, { noremap = true, silent = true})
        vim.keymap.set('n', '<C-P>', function() require'telescope.builtin'.find_files() end, { noremap = true, silent = true})

        -- LSP
        vim.keymap.set('n', 'gD', function() require'telescope.builtin'.lsp_type_definitions() end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gd', function() require'telescope.builtin'.lsp_definitions() end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gi', function() require'telescope.builtin'.lsp_implementations() end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gs', function() require'telescope.builtin'.diagnostics() end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gr', function() require'telescope.builtin'.lsp_references() end, { noremap = true, silent = true })
    end
}
