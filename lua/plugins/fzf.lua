return {
    'ibhagwan/fzf-lua',
    lazy = true,
    opts = {
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
    },
    init = function()
        ---@diagnostic disable: duplicate-set-field
        vim.keymap.set('n', '//', function() require'fzf-lua'.blines() end, { noremap = true, silent = true})
        vim.keymap.set('n', '??', function() require'fzf-lua'.lgrep_curbuf() end, { noremap = true, silent = true})
        vim.keymap.set('n', '<C-_><C-_>', function() require'fzf-lua'.buffers() end, { noremap = true, silent = true})
        vim.keymap.set('n', '<C-P>', function() require'fzf-lua'.files() end, { noremap = true, silent = true})

        -- LSP
        vim.keymap.set('n', 'gD', function() require'fzf-lua'.lsp_declarations({ jump_to_single_result = true }) end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gd', function() require'fzf-lua'.lsp_definitions({ jump_to_single_result = true }) end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gi', function() require'fzf-lua'.lsp_implementations({ jump_to_single_result = true }) end, { noremap = true, silent = true })
        vim.keymap.set('n', 'go', function() require'fzf-lua'.lsp_document_diagnostics() end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gO', function() require'fzf-lua'.lsp_workspace_diagnostics() end, { noremap = true, silent = true })
        vim.keymap.set('n', 'gr', function() require'fzf-lua'.lsp_references() end, { noremap = true, silent = true })
    end,
    dependencies = {
        {
            'junegunn/fzf',
            build = './install --bin',
            cond = vim.fn.filereadable(vim.env.HOME .. '/.local/share/nvim/site/pack/packer/opt/fzf/bin/fzf-tmux') == 0
        },
    }
}
