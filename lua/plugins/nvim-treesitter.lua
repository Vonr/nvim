return {
    'nvim-treesitter/nvim-treesitter',
    -- ft = (function()
    --     local dir = vim.env.XDG_DATA_HOME .. '/nvim/lazy/nvim-treesitter/parser-info'
    --     local fx = require('functions')
    --     local parsers = {}
    --     for parser in string.gmatch(
    --         fx.capture('/bin/ls -1 ' .. dir, true),
    --         '([^.]*).revision\n'
    --     ) do
    --         if string.len(parser) > 0 then
    --             table.insert(parsers, parser)
    --         end
    --     end
    --
    --     return parsers
    -- end)(),
    config = function()
        require'nvim-treesitter.configs'.setup({
            ignore_install = {},
            ensure_installed = {},
            highlight = {
                enable = true,
                disable = {
                    'latex'
                },
                additional_vim_regex_highlighting = {
                    'html'
                },
            },
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            textobjects = {
                enable = false, -- false will disable the whole extension
                disable = {}, -- list of textobjects that will be disabled
                additional_vim_regex_highlighting = false,
            },
            playground = {
                enable = true,
            },
        })

        -- Custom highlights
        vim.api.nvim_set_hl(0, "@type.qualifier.dart", { link = "Label" })
        vim.api.nvim_set_hl(0, "@attribute.dart", { link = "Identifier" })
    end,
}
