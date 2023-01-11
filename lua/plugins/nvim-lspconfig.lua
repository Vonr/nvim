return {
    'neovim/nvim-lspconfig',
    ft = {
        'python', 'bash', 'typescript', 'css', 'html', 'javascript', 'svelte', 'prisma', 'go', 'haskell', 'lua'
    },
    config = function()
        ---@diagnostic disable: duplicate-set-field
        local config = require'lspconfig'

        -- logged to ~/.cache/nvim/lsp.log
        vim.lsp.set_log_level("ERROR")

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
