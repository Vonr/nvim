return {
    dir = '~/.config/nvim/lua/plugins/dev/align.nvim',
    dev = true,
    lazy = true,
    init = function()
        local NS = { noremap = true, silent = true }

        vim.keymap.set('x', 'aa', function() require'align'.align_to_char(1, true)             end, NS)
        vim.keymap.set('x', 'as', function() require'align'.align_to_char(2, true, true)       end, NS)
        vim.keymap.set('x', 'aw', function() require'align'.align_to_string(false, true, true) end, NS)
        vim.keymap.set('x', 'ar', function() require'align'.align_to_string(true, true, true)  end, NS)

        vim.keymap.set(
        'n',
        'gaw',
        function()
            local a = require'align'
            a.operator(
            a.align_to_string,
            { is_pattern = false, reverse = true, preview = true }
            )
        end,
        NS
        )

        vim.keymap.set(
        'n',
        'gaa',
        function()
            local a = require'align'
            a.operator(
            a.align_to_char,
            { reverse = true }
            )
        end,
        NS
        )

        vim.keymap.set(
        'n',
        'gaW',
        function()
            local a = require'align'
            a.operator(
            a.align_to_string,
            { reverse = true, preview = true },
            function()
                vim.cmd[[normal! gv]]
            end
            )
        end,
        NS
        )
    end,
}
