vim.keymap.set('n', '//', function() _G.load_fzf_lua().blines() end, { noremap = true, silent = true})
vim.keymap.set('n', '??', function() _G.load_fzf_lua().lgrep_curbuf() end, { noremap = true, silent = true})
vim.keymap.set('n', '<C-_><C-_>', function() _G.load_fzf_lua().buffers() end, { noremap = true, silent = true})
vim.keymap.set('n', '<C-P>', function() _G.load_fzf_lua().files() end, { noremap = true, silent = true})

-- LSP
vim.keymap.set('n', 'gD', function() _G.load_fzf_lua().lsp_declarations({ jump_to_single_result = true }) end, { noremap = true, silent = true })
vim.keymap.set('n', 'gd', function() _G.load_fzf_lua().lsp_definitions({ jump_to_single_result = true }) end, { noremap = true, silent = true })
vim.keymap.set('n', 'gi', function() _G.load_fzf_lua().lsp_implementations({ jump_to_single_result = true }) end, { noremap = true, silent = true })
vim.keymap.set('n', 'go', function() _G.load_fzf_lua().lsp_document_diagnostics() end, { noremap = true, silent = true })
vim.keymap.set('n', 'gO', function() _G.load_fzf_lua().lsp_workspace_diagnostics() end, { noremap = true, silent = true })
vim.keymap.set('n', 'gr', function() _G.load_fzf_lua().lsp_references() end, { noremap = true, silent = true })

function _G.load_fzf_lua()
    _G.load_fzf_lua = function() return _G.fzf end
    vim.cmd'PackerLoad fzf-lua'
    _G.fzf = require'fzf-lua'
    _G.fzf.setup {
        winopts = {
            hl = {
                border = 'FloatBorder',
            },
            preview = {
                layout = 'flex',
                horizontal = 'right:65%',
                vertical = 'down:45%',
                title = false,
                scrollbar = 'float',
            },
        },
    }
    return _G.fzf
end
