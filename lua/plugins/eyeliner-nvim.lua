return {
    'jinh0/eyeliner.nvim',
    keys = {
        { mode = 'n', 'f' },
        { mode = 'n', 'F' },
        { mode = 'n', 't' },
        { mode = 'n', 'T' },
    },
    config = function()
        vim.api.nvim_set_hl(0, 'EyelinerPrimary', {
            fg = '#d3869b',
            bold = true,
            underline = true
        })
        require('eyeliner').setup({
            highlight_on_key = true,
            dim = true,
        })
    end
}
