return {
    'neovim/nvim-lspconfig',
    event = 'BufRead',
    config = function()
        ---@diagnostic disable: duplicate-set-field
        local config = require'lspconfig'

        -- logged to ~/.cache/nvim/lsp.log
        vim.lsp.set_log_level('ERROR')

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        capabilities.textDocument.codeAction = {
            dynamicRegistration = false,
            codeActionLiteralSupport = {
                codeActionKind = {
                    valueSet = {
                        '',
                        'quickfix',
                        'refactor',
                        'refactor.extract',
                        'refactor.inline',
                        'refactor.rewrite',
                        'source',
                        'source.organizeImports',
                        'source.fixAll',
                    }
                }
            }
        }

        local default = {
            on_attach = function() end,
            autostart = true,
            capabilities = capabilities,
        }

        local external = function(name)
            local out = require('plugins/lspconfig/' .. name)
            if type(out) == 'function' then
                out = out(default)
            end
            return out
        end

        local configs = {
            bashls        = default,
            tsserver      = default,
            cssls         = default,
            emmet_ls      = default,
            ccls          = default,
            svelte        = default,
            prismals      = default,
            pylsp         = default,
            texlab        = default,
            zls           = default,
            eslint        = default,
            wgsl_analyzer = default,
            tailwindcss   = default,
            gopls         = external('go'),
            html          = external('html'),
            lua_ls        = external('lua_ls'),
        }

        local lua_loaded = false
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'lua',
            callback = function()
                if lua_loaded then return end
                require("neodev").setup()
                config['lua_ls'].setup(external('lua_ls'))
                lua_loaded = true
            end
        })

        for server, opts in pairs(configs) do
            config[server].setup(opts)
        end

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = true,
            signs = { active = signs },
        })
        local lines_enabled = true

        vim.keymap.set({'n', 'x'}, 'gx',  vim.lsp.buf.code_action,     { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename,          { noremap = true, silent = true })
        vim.keymap.set('n', '<C-k>',      vim.lsp.buf.signature_help,  { noremap = true, silent = true })
        vim.keymap.set('n', '[g',         vim.diagnostic.goto_prev,    { noremap = true, silent = true })
        vim.keymap.set('n', 'g[',         vim.diagnostic.goto_prev,    { noremap = true, silent = true })
        vim.keymap.set('n', 'g]',         vim.diagnostic.goto_next,    { noremap = true, silent = true })
        vim.keymap.set('n', ']g',         vim.diagnostic.goto_next,    { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>vd', function()
            lines_enabled = not lines_enabled
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = lines_enabled,
                signs = { active = signs },
            })
        end)

        vim.o.updatetime = 300

        local function lazyLspPlugin(pattern, plugin)
            if type(pattern) == 'string' then
                pattern = {pattern}
            end
            local plugin_group = vim.api.nvim_create_augroup("lsp_" .. plugin, { clear = true })
            vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
                pattern = pattern,
                group = plugin_group,
                callback = function()
                    local _ = require(plugin)
                    vim.cmd'LspStart'
                    vim.api.nvim_clear_autocmds({ group = 'lsp' .. plugin })
                end,
            })
        end

        lazyLspPlugin('*.go', 'go')
    end,
    dependencies = {
        {
            'ErichDonGubler/lsp_lines.nvim',
            lazy = true,
            config = true,
        },
        'windwp/nvim-autopairs',
    }
}
