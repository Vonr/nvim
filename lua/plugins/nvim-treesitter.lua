return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    config = function()
        vim.g.no_plugin_maps = true

        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter').setup({
        })

        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.parsers').sfml = {
            ---@diagnostic disable-next-line: missing-fields
            install_info = {
                path = '~/git/tree-sitter-sfml',
                location = 'parser',
                generate = true,
                generate_from_json = false,
            },
        }

        -- Custom highlights
        vim.api.nvim_set_hl(0, "@type.qualifier.dart", { link = "Label" })
        vim.api.nvim_set_hl(0, "@attribute.dart", { link = "Identifier" })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '*' },
            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()

                if vim.treesitter.language.get_lang(vim.bo[bufnr].filetype) ~= nil then
                    vim.treesitter.start()
                end
            end,
        })


        local to_bind = function(bind, qs, qg)
            vim.keymap.set(
                { "x", "o" },
                bind,
                function()
                    require('nvim-treesitter-textobjects.select').select_textobject(qs, qg)
                end
            )
        end

        to_bind('af', '@function.outer', 'textobjects')
        to_bind('if', '@function.inner', 'textobjects')
        to_bind('ac', '@class.inner', 'textobjects')
        to_bind('ic', '@class.outer', 'textobjects')
        to_bind('as', '@local.scope', 'locals')
    end,
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            branch = 'main',
            lazy = true,
            keys = {
                { mode = { 'x', 'o' }, 'af' },
                { mode = { 'x', 'o' }, 'if' },
                { mode = { 'x', 'o' }, 'ac' },
                { mode = { 'x', 'o' }, 'ic' },
                { mode = { 'x', 'o' }, 'as' },
            },
            config = function()
                require("nvim-treesitter-textobjects").setup({
                    select = {
                        lookahead = true,
                        selection_modes = {
                            ['@parameter.outer'] = 'v',
                            ['@function.outer'] = 'V',
                        },
                        include_surrounding_whitespace = false,
                    },
                })
            end
        },
    }
}
