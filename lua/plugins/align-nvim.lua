return {
    dir = '~/.config/nvim/lua/plugins/dev/align.nvim',
    dev = true,
    lazy = true,
    init = function()
        local NS = { noremap = true, silent = true }

        vim.keymap.set(
            'x',
            'aa',
            function()
                require'align'.align_to_char({
                    length = 1,
                })
            end,
            NS
        )

        vim.keymap.set(
            'x',
            'ad',
            function()
                require'align'.align_to_char({
                    preview = true,
                    length = 2,
                })
            end,
            NS
        )

        vim.keymap.set(
            'x',
            'aw',
            function()
                require'align'.align_to_string({
                    preview = true,
                    regex = false,
                })
            end,
            NS
        )

        vim.keymap.set(
            'x',
            'ar',
            function()
                require'align'.align_to_string({
                    preview = true,
                    regex = true,
                })
            end,
            NS
        )

        vim.keymap.set(
            'n',
            'gaw',
            function()
                local a = require'align'
                a.operator(
                    a.align_to_string,
                    {
                        preview = true,
                        regex = false,
                    }
                )
            end,
            NS
        )

        vim.keymap.set(
            'n',
            'gaa',
            function()
                local a = require'align'
                a.operator(a.align_to_char)
            end,
            NS
        )
    end,
}
