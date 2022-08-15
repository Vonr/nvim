require('luasnip.loaders.from_lua').lazy_load({paths = os.getenv('HOME') .. '/.config/nvim/lua/snippets'})

local luasnip = require('luasnip')

luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set('n', '<leader><C-s>', function() require("luasnip.loaders.from_lua").edit_snippet_files() end, { noremap = true, silent = true })
