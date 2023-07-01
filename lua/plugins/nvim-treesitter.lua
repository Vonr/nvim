return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require'nvim-treesitter.configs'.setup({
            ignore_install = {}, -- List of parsers to ignore installing
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
                enable = true, -- false will disable the whole extension
                disable = {}, -- list of textobjects that will be disabled
                -- Set this to true if you depend on 'textobjects' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
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
