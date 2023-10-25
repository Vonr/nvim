return {
    'L3MON4D3/LuaSnip',
    lazy = true,
    config = function()
        require('luasnip').config.set_config({
            history = false,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
        })
    end,
}
