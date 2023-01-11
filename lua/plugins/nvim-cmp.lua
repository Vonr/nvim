return {
    'hrsh7th/nvim-cmp',
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
                    _G.load_luasnip().lsp_expand(args.body)
                end
            },
            mapping = {
                ['<C-k>'] = cmp.mapping.scroll_docs(-3),
                ['<C-j>'] = cmp.mapping.scroll_docs(4),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                }),
                ['<C-d>'] = cmp.mapping.close(),
                -- ['<Down>'] = cmp.mapping.close(),
                -- ['<Up>'] = cmp.mapping.close(),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping(function()
                    if vim.fn['copilot#GetDisplayedSuggestion']().text ~= "" then
                        vim.fn['copilot#Dismiss']()
                    else
                        cmp.mapping.abort()
                    end
                end, {'i', 's'}),
                ['<C-n>'] = cmp.mapping(function(fallback)
                    if _G.load_luasnip().jumpable(1) then
                        _G.load_luasnip().jump(1)
                    elseif _G.load_luasnip().expand_or_jumpable() then
                        _G.load_luasnip().expand_or_jump()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif _G.load_luasnip().expand_or_jumpable() then
                        _G.load_luasnip().expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<C-p>'] = cmp.mapping(function(fallback)
                    if _G.load_luasnip().jumpable(-1) then
                        _G.load_luasnip().jump(-1)
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
                    if _G.load_luasnip().jumpable(1) then
                        _G.load_luasnip().jump(1)
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<S-Left>'] = cmp.mapping(function(fallback)
                    if _G.load_luasnip().jumpable(-1) then
                        _G.load_luasnip().jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'}),
            },
            sources = {
                { name = 'cmp_tabnine' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'treesitter' },
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp                = " ",
                        cmp_tabnine             = "🤖",
                        buffer                  = " ",
                        luasnip                 = " ",
                        latex_symbols           = "✕ ",
                        nvim_lsp_signature_help = " ",
                        treesitter              = "🌲",
                        path                    = "📁",
                    })[entry.source.name]
                    vim_item.kind = ({
                        Variable = " ",
                        Field    = " ",
                        Function = " ",
                        Text     = " ",
                    })[vim_item.kind]

                    return vim_item
                end,
            },
        })

        require('nvim-autopairs').setup{}
        local cmp_ap = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_ap.on_confirm_done({ map_char = { tex = '' }}))
    end
}
