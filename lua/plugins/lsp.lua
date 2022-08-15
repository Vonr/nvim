local config = require'lspconfig'
local cmp = require'cmp'

-- logged to ~/.cache/nvim/lsp.log
-- vim.lsp.set_log_level("debug")

require('nvim-autopairs').setup{}
local cmp_ap = require('nvim-autopairs.completion.cmp')

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local default = {
  on_attach = function() end, autostart = true, capabilities = capabilities
}

local configs = {
    pyright  = default,
    bashls   = default,
    tsserver = default,
}

for server, opts in pairs(configs) do
   config[server].setup(opts)
end

cmp.setup({
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
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
        ['<C-e>'] = function()
            if vim.fn['copilot#GetDisplayedSuggestion']().text ~= "" then
                vim.fn['copilot#Dismiss']()
            else
                cmp.mapping.abort()
            end
        end,
        ['<C-n>'] = function(fallback)
            if require'luasnip'.jumpable(1) then
                require'luasnip'.jump(1)
            elseif require'luasnip'.expand_or_jumpable() then
                require'luasnip'.expand_or_jump()
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<Tab>'] = function(fallback)
            -- if require'luasnip'.choice_active() then
            --     require'luasnip'.change_choice(1)
            -- elseif require'luasnip'.expand_or_jumpable() then
            --     require'luasnip'.expand_or_jump()
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<C-p>'] = function(fallback)
            if require'luasnip'.jumpable(-1) then
                require'luasnip'.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            -- if require'luasnip'.choice_active() then
            --     require'luasnip'.change_choice(-1)
            -- elseif require'luasnip'.jumpable(-1) then
            --     require'luasnip'.jump(-1)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
        ['<S-Right>'] = function(fallback)
            if require'luasnip'.jumpable(1) then
                require'luasnip'.jump(1)
            else
                fallback()
            end
        end,
        ['<S-Left>'] = function(fallback)
            if require'luasnip'.jumpable(-1) then
                require'luasnip'.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'treesitter' },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                    buffer                  = " ",
                    nvim_lsp                = " ",
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
            Debug = vim_item

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

-- vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gx',         function() vim.lsp.buf.code_action()    end, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>rn', function() vim.lsp.buf.rename()         end, { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>',      function() vim.lsp.buf.signature_help() end, { noremap = true, silent = true })
vim.keymap.set('n', '[g',         function() vim.diagnostic.goto_prev()   end, { noremap = true, silent = true })
vim.keymap.set('n', ']g',         function() vim.diagnostic.goto_next()   end, { noremap = true, silent = true })

vim.o.updatetime = 300
LastLspHoldPosition = nil
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local newPos = {
            cursor[1],
            cursor[2],
        }
        if LastLspHoldPosition ~= nil and LastLspHoldPosition[1] == newPos[1] and LastLspHoldPosition[2] == newPos[2] then
            return
        end
        LastLspHoldPosition = newPos
        vim.diagnostic.open_float(nil, { focus=false, scope='cursor' })
    end
})

local function lazyLspConfig(pattern, name)
    if type(pattern) == 'string' then
        pattern = {pattern}
    end
    vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
        pattern = pattern,
        callback = function()
            vim.api.nvim_create_augroup("lsp_" .. name, { clear = true })
            require('plugins/lspconfig/' .. name)
        end,
    })
end

local function lazyLspPlugin(pattern, plugin)
    if type(pattern) == 'string' then
        pattern = {pattern}
    end
    vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
        pattern = pattern,
        callback = function()
            vim.api.nvim_create_augroup("lsp_" .. plugin, { clear = true })
            vim.cmd('PackerLoad ' .. plugin)
        end,
    })
end

lazyLspConfig('*.lua', 'sumneko_lua')
lazyLspConfig('*.hs',  'hls')

lazyLspPlugin('*.rs', 'rust-tools.nvim')
lazyLspPlugin('*.go', 'go.nvim')
lazyLspPlugin('*sh',  'null-ls.nvim')

lazyLspPlugin({ '*.java'
              , 'pom.xml'
              , 'build.gradle'
              }, 'nvim-jdtls')

