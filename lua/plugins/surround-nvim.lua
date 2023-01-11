return {
    'ur4ltz/surround.nvim',
    keys = { {'s', mode = {'n', 'x'}} },
    config = function()
        require"surround".setup { mappings_style = "sandwich" }
    end
}
