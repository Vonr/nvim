return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
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
                enable = true,
                disable = {},
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = true,
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        ["]o"] = "@loop.*",
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                    },
                    goto_next_end = {},
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[o"] = "@loop.*",
                        ["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {},
                    goto_next = {},
                    goto_previous = {}
                },
            },
            playground = {
                enable = true,
            },
        })

        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        ---@diagnostic disable-next-line: inject-field
        parser_config.sfml = {
            install_info = {
                url = '~/git/tree-sitter-sfml',
                files = { 'src/parser.c' },
            },
            filetype = 'sfml',
        }
        vim.treesitter.language.register('sfml', 'sfml')

        -- Custom highlights
        vim.api.nvim_set_hl(0, "@type.qualifier.dart", { link = "Label" })
        vim.api.nvim_set_hl(0, "@attribute.dart", { link = "Identifier" })
    end,
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            lazy = true,
        },
    }
}
