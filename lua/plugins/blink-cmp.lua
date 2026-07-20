return {
    'saghen/blink.cmp',
    branch = 'main',
    enabled = true,
    build = function()
        ---@diagnostic disable-next-line: undefined-field
        require('blink.cmp').build():pwait()
    end,
    config = function()
        local blink = require('blink-cmp')

        local prev_cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
        local skips = 0
        vim.api.nvim_create_autocmd('CursorMovedI', {
            callback = function()
                if skips > 0 then
                    skips = skips - 1
                    return
                end
                if blink.is_visible() then
                    local cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
                    if cursor[1] ~= prev_cursor[1] or cursor[2] - prev_cursor[2] ~= 1 then
                        blink.hide()
                    end
                    prev_cursor = cursor
                end
            end
        })

        ---@type blink.cmp.KeymapCommand
        local select_next = function(cmp)
            skips = skips + 1
            return cmp.select_next()
        end

        ---@type blink.cmp.KeymapCommand
        local select_prev = function(cmp)
            skips = skips + 1
            return cmp.select_prev()
        end

        ---@type blink.cmp.Config
        local opts = {
            keymap = {
                preset = 'none',
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
                ['<Tab>'] = { select_next, 'fallback' },
                ['<S-Tab>'] = { select_prev, 'fallback' },
                ['<Up>'] = { select_prev, 'fallback' },
                ['<Down>'] = { select_next, 'fallback' },
                ['<Enter>'] = { 'select_and_accept', 'fallback' },
                ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
                ['<S-Left>'] = { function()
                    if require('luasnip').jumpable(1) then
                        require('luasnip').jump(1)
                        return true
                    end
                    return false
                end, 'fallback' },
                ['<S-Right>'] = { function()
                    if require('luasnip').jumpable(1) then
                        require('luasnip').jump(1)
                        return true
                    end
                    return false
                end, 'fallback' },
                ['<Esc>'] = { function(cmp)
                    if cmp.is_visible() then
                        cmp.hide()
                    end
                    vim.cmd.stopinsert()
                end },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                documentation = {
                    auto_show = true
                }
            },
            snippets = {
                preset = 'luasnip'
            },
            signature = { enabled = true },
            sources = {
                default = { 'lsp', 'path', 'snippets' },
                per_filetype = {
                    lua = { inherit_defaults = true, 'lazydev' },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    lsp = {
                        name = 'LSP',
                        module = 'blink.cmp.sources.lsp',
                        transform_items = function(_, items)
                            return vim.tbl_filter(function(item)
                                return item.kind ~= require('blink.cmp.types').CompletionItemKind.Keyword
                            end, items)
                        end,
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        }

        blink.setup(opts)
    end,
    dependencies = {
        'saghen/blink.lib',
    },
}
