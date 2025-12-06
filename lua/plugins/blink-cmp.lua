return {
    'saghen/blink.cmp',
    version = '1.*',
    enabled = false,
    opts_extend = { "sources.default" },
    config = function()
        local blink = require('blink-cmp')

        ---@type blink.cmp.Config
        local opts = {
            keymap = {
                preset = 'enter',
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<Enter>'] = { 'select_and_accept', 'fallback' },
                ['<C-e>'] = {},
                ['<Esc>'] = { function(cmp)
                    if cmp.is_visible() then
                        cmp.hide()
                    else
                        vim.cmd.stopinsert()
                    end
                    return true
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
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        }

        blink.setup(opts)
    end
}
