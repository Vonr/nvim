return {
    'rebelot/kanagawa.nvim',
    enabled = vim.g.colors_name == 'kanagawa',
    event = 'UIEnter',
    config = function()
        require('kanagawa').setup({
            compile = true,
            undercurl = true,
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = false },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,
            dimInactive = false,
            terminalColors = true,
            colors = {
                theme = {
                    wave = {},
                    lotus = {},
                    dragon = {},
                    all = {
                        ui = {
                            bg_gutter = 'none',
                        }
                    }
                },
            },
            overrides = function(colors) -- add/modify highlights
                return {}
            end,
            theme = 'wave',
            background = {
                dark = 'dragon',
                light = 'lotus'
            },
        })

        _G.Theme = require('kanagawa.colors').setup({
            theme = 'wave'
        })

        vim.cmd.colorscheme("kanagawa-wave")
    end
}
