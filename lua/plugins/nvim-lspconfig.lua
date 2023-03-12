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

        local default = {
            on_attach = function() end,
            autostart = true,
            capabilities = capabilities,
        }

        local configs = {
            pyright     = default,
            bashls      = default,
            tsserver    = default,
            cssls       = default,
            emmet_ls    = default,
            ccls        = default,
            svelte      = default,
            prismals    = default,
            pylsp       = default,
            texlab      = default,
            gopls       = require'plugins/lspconfig/go',
            omnisharp   = require'plugins/lspconfig/omnisharp',
            html        = require'plugins/lspconfig/html',
            hls         = require'plugins/lspconfig/hls',
            lua_ls      = require'plugins/lspconfig/lua_ls',
        }

        for server, opts in pairs(configs) do
            config[server].setup(opts)
        end

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        vim.diagnostic.config({
            virtual_text = false,
            signs = { active = signs },
        })

        vim.keymap.set('n', 'gx',         vim.lsp.buf.code_action,    { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename,         { noremap = true, silent = true })
        vim.keymap.set('n', '<C-k>',      vim.lsp.buf.signature_help, { noremap = true, silent = true })
        vim.keymap.set('n', '[g',         vim.diagnostic.goto_prev,   { noremap = true, silent = true })
        vim.keymap.set('n', 'g[',         vim.diagnostic.goto_prev,   { noremap = true, silent = true })
        vim.keymap.set('n', 'g]',         vim.diagnostic.goto_next,   { noremap = true, silent = true })
        vim.keymap.set('n', ']g',         vim.diagnostic.goto_next,   { noremap = true, silent = true })

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

        lazyLspPlugin('*.go', 'go')

        lazyLspPlugin({
            "css",
            "graphql",
            "html",
            "javascript",
            "javascriptreact",
            "json",
            "less",
            "markdown",
            "scss",
            "typescript",
            "typescriptreact",
            "yaml",
        }, 'null-ls')
    end,
    dependencies = {
        {
            -- Can't lazy load neodev to my knowledge, see https://github.com/folke/lazy.nvim/issues/471
            'folke/neodev.nvim',
            ft = 'lua',
            config = true,
        }
    }
}
