return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
        local lspconfig = require('lspconfig')

        -- logged to ~/.cache/nvim/lsp.log
        vim.lsp.log.set_level('ERROR')

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
            ts_ls         = default,
            cssls         = default,
            emmet_ls      = default,
            ccls          = default,
            svelte        = default,
            prismals      = default,
            -- pylsp         = default,
            ruff          = external('ruff'),
            basedpyright  = external('pyright'),
            texlab        = default,
            zls           = default,
            eslint        = default,
            wgsl_analyzer = default,
            tailwindcss   = default,
            dockerls      = default,
            astro         = default,
            gopls         = external('go'),
            html          = external('html'),
            lua_ls        = external('lua_ls'),
            ltex          = vim.tbl_extend('force', default,
                { on_attach = function() require('ltex_extra').setup({}) end }),
        }

        for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
            local default_diagnostic_handler = vim.lsp.handlers[method]
            vim.lsp.handlers[method] = function(err, result, context, cfg)
                if err ~= nil and err.code == -32802 then
                    return
                end
                return default_diagnostic_handler(err, result, context, cfg)
            end
        end

        -- local lua_loaded = false
        -- vim.api.nvim_create_autocmd('FileType', {
        --     pattern = 'lua',
        --     callback = function()
        --         if lua_loaded then return end
        --         config['lua_ls'].setup(external('lua_ls'))
        --         lua_loaded = true
        --     end
        -- })

        for server, opts in pairs(configs) do
            vim.lsp.config(server, vim.tbl_deep_extend('force', require('lspconfig.configs.' .. server), default, opts))
            vim.lsp.enable(server)
        end

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = true,
            signs = { active = signs },
        })
        local lines_enabled = true

        vim.keymap.set({ 'n', 'x' }, 'gx', vim.lsp.buf.code_action, { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
        vim.keymap.set('n', '[g', function() vim.diagnostic.jump({ count = -1, float = true }) end,
            { noremap = true, silent = true })
        vim.keymap.set('n', 'g[', function() vim.diagnostic.jump({ count = -1, float = true }) end,
            { noremap = true, silent = true })
        vim.keymap.set('n', 'g]', function() vim.diagnostic.jump({ count = 1, float = true }) end,
            { noremap = true, silent = true })
        vim.keymap.set('n', ']g', function() vim.diagnostic.jump({ count = 1, float = true }) end,
            { noremap = true, silent = true })
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
                pattern = { pattern }
            end
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
                pattern = pattern,
                once = true,
                callback = function()
                    local _ = require(plugin)
                    vim.cmd 'LspStart'
                end,
            })
        end

        lazyLspPlugin('*.go', 'go')

        -- Inlay Hints (Neovim 0.10+)
        -- if vim.fn.has('nvim-0.10') then
        --     vim.api.nvim_create_autocmd('LspAttach', {
        --         callback = function()
        --             vim.lsp.inlay_hint.enable()
        --         end
        --     })
        -- end

        vim.api.nvim_create_user_command('LspLog', [[lua vim.cmd('tabnew ' .. vim.lsp.log.get_filename())]], {})
    end,
    dependencies = {
        {
            'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
            config = true,
        },
        'windwp/nvim-autopairs',
        'mason-org/mason-lspconfig.nvim',
    }
}
