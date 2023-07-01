---@diagnostic disable: assign-type-mismatch

return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
        local cmp = require'cmp'

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    require'luasnip'.lsp_expand(args.body)
                end
            },

            mapping = {
                ['<C-k>'] = cmp.mapping.scroll_docs(-3),
                ['<C-j>'] = cmp.mapping.scroll_docs(3),

                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                }),

                ['<C-d>'] = cmp.mapping.close(),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),

                ['<C-n>'] = cmp.mapping(function(fallback)
                    if require'luasnip'.jumpable(1) then
                        require'luasnip'.jump(1)
                    elseif require'luasnip'.expand_or_locally_jumpable() then
                        require'luasnip'.expand_or_jump()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require'luasnip'.expand_or_locally_jumpable() then
                        require'luasnip'.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<C-p>'] = cmp.mapping(function(fallback)
                    if require'luasnip'.jumpable(-1) then
                        require'luasnip'.jump(-1)
                    elseif cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<S-Right>'] = cmp.mapping(function(fallback)
                    if require'luasnip'.jumpable(1) then
                        require'luasnip'.jump(1)
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<S-Left>'] = cmp.mapping(function(fallback)
                    if require'luasnip'.jumpable(-1) then
                        require'luasnip'.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'}),
            },

            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'luasnip' },
                { name = 'path' },
            },

            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp                = " ",
                        buffer                  = " ",
                        luasnip                 = " ",
                        latex_symbols           = "✕ ",
                        nvim_lsp_signature_help = " ",
                        path                    = "📁",
                    })[entry.source.name]

                    vim_item.kind = ({
                        Variable = " ",
                        Field    = " ",
                        Function = "󰊕 ",
                        Text     = " ",
                    })[vim_item.kind]

                    return vim_item
                end,
            },
        })

        local cmp_ap = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_ap.on_confirm_done({ map_char = { tex = '' } }))
    end,
    dependencies = {
        {
            'hrsh7th/cmp-nvim-lsp',
            dependencies = {
                'neovim/nvim-lspconfig',
            }
        },
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = {
                {
                    'L3MON4D3/LuaSnip',
                    config = function()
                        require('luasnip.loaders.from_lua').lazy_load({paths = vim.env.HOME .. '/.config/nvim/lua/snippets'})

                        require'luasnip'.config.set_config({
                            history = false,
                            updateevents = "TextChanged,TextChangedI",
                            enable_autosnippets = true,
                        })

                        vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
                        vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
                        vim.keymap.set('n', '<leader><C-s>', function() require("luasnip.loaders.from_lua").edit_snippet_files() end, { noremap = true, silent = true })
                    end,
                }
            }
        },
    }
}
