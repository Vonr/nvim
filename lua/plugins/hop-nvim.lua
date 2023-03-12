return {
    'phaazon/hop.nvim',
    keys = {
        {'<C-q>', mode = {'n', 'x', 'i'}},
        {'<Leader><C-q>', mode = {'n', 'x'}},
        {'dqq', mode = 'n'},
        {'dqf', mode = 'n'},
        {'dqt', mode = 'n'},
        {'<Leader>qw', mode = {'n', 'x'}},
        {'dfw', mode = 'n'},
        {'<Leader>qr', mode = {'n', 'x'}},
        {'dqr', mode = 'n'},
        {'<Leader>qe', mode = {'n', 'x'}},
        {'dqe', mode = 'n'},
    },
    config = function()
        local hop = require'hop'
        local dir = require'hop.hint'.HintDirection

        hop.setup { keys = 'asldfkqwerpomznxgjhitucbv' }

        vim.keymap.set({'n', 'x', 'i'}, '<C-q>', function() hop.hint_char1({ direction = nil, current_line_only = false }) end, {})
        vim.keymap.set({'n', 'x'}, '<Leader><C-q>', function() hop.hint_char1({ direction = nil, current_line_only = false }) end, {})
        vim.keymap.set('n', 'dqq', function() _G.hop_delete_to_char() end, {})
        vim.keymap.set('n', 'dqf', function() _G.hop_delete_to_char_line() end, {})
        vim.keymap.set('n', 'dqt', function() _G.hop_delete_until_char_line() end, {})
        vim.keymap.set({'n', 'x'}, '<Leader>qw', function() hop.hint_words({ direction = nil, current_line_only = false }) end, {})
        vim.keymap.set('n', 'dfw', function() _G.hop_delete_to_word() end, {})
        vim.keymap.set({'n', 'x'}, '<Leader>qr', function() hop.hint_patterns({ direction = nil, current_line_only = false }) end, {})
        vim.keymap.set('n', 'dqr', function() _G.hop_delete_to_pattern() end, {})
        vim.keymap.set({'n', 'x'}, '<Leader>qe', function() hop.hint_anywhere({ direction = nil, current_line_only = false }) end, {})
        vim.keymap.set('n', 'dqe', function() _G.hop_delete_to_anywhere() end, {})

        local function delete_to(fn, opts, action)
        if opts == nil then opts = { direction = dir.AFTER_CURSOR, current_line_only = false } end
            if action == nil then action = 'd' end
            vim.api.nvim_feedkeys('v', 'n', true)
            vim.schedule(function()
                fn(opts)
                vim.api.nvim_feedkeys(action, 'n', false)
            end)
        end

        _G.hop_delete_to_char = function()
            delete_to(hop.hint_char1)
        end

        _G.hop_delete_to_char_line = function()
            delete_to(
            hop.hint_char1,
            { direction = dir.AFTER_CURSOR, current_line_only = true }
            )
        end

        _G.hop_delete_until_char_line = function()
            delete_to(
            hop.hint_char1,
            { direction = dir.AFTER_CURSOR, current_line_only = true },
            'hd'
            )
        end

        _G.hop_delete_to_word = function()
            delete_to(hop.hint_words)
        end

        _G.hop_delete_to_pattern = function()
            delete_to(hop.hint_patterns)
        end

        _G.hop_delete_to_anywhere = function()
            delete_to(hop.hint_anywhere)
        end
    end,
}
