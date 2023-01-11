return {
    'neovim/nvim-lspconfig',
    config = function()
        ---@diagnostic disable: duplicate-set-field
        local config = require'lspconfig'
        local cmp = require'cmp'

        _G.load_luasnip = function()
            _G.luasnip = require'luasnip'
            require'cmp-luasnip'
            _G.load_luasnip = function() return _G.luasnip end
            return _G.luasnip
        end

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        -- logged to ~/.cache/nvim/lsp.log
        vim.lsp.set_log_level("ERROR")

        require('nvim-autopairs').setup{}
        local cmp_ap = require('nvim-autopairs.completion.cmp')

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local default = {
            on_attach = function() end, autostart = true, capabilities = capabilities
        }

        local configs = {
            pyright     = default,
            bashls      = default,
            tsserver    = default,
            cssls       = default,
            emmet_ls    = default,
            ccls        = default,
            svelte      = default,
            tailwindcss = default,
            prismals    = default,
            pylsp       = default,
            gopls       = require'plugins/lspconfig/go',
            omnisharp   = require'plugins/lspconfig/omnisharp',
            html        = require'plugins/lspconfig/html',
            hls         = require'plugins/lspconfig/hls',
            sumneko_lua = require'plugins/lspconfig/sumneko_lua',
        }

        for server, opts in pairs(configs) do
            config[server].setup(opts)
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

        cmp.event:on('confirm_done', cmp_ap.on_confirm_done({ map_char = { tex = '' }}))

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        vim.diagnostic.config({
            virtual_text = false,
            signs = { active = signs },
        })

        vim.keymap.set('n', 'gx',         function() vim.lsp.buf.code_action()    end, { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>rn', function() vim.lsp.buf.rename()         end, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-k>',      function() vim.lsp.buf.signature_help() end, { noremap = true, silent = true })
        vim.keymap.set('n', '[g',         function() vim.diagnostic.goto_prev()   end, { noremap = true, silent = true })
        vim.keymap.set('n', ']g',         function() vim.diagnostic.goto_next()   end, { noremap = true, silent = true })

        vim.o.updatetime = 300

        local function lazyLspPlugin(pattern, plugin)
            if type(pattern) == 'string' then
                pattern = {pattern}
            end
            vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
                pattern = pattern,
                callback = function()
                    vim.api.nvim_create_augroup("lsp_" .. plugin, { clear = true })
                    local _ = require(plugin)
                    vim.cmd'LspStart'
                end,
            })
        end

        lazyLspPlugin('*.rs', 'rust-tools')
        lazyLspPlugin('*.go', 'go')

        lazyLspPlugin({ '*sh', "*.js", "*.ts" }, 'null-ls')
    end,
}
