local fx = require'functions'
local NS = { noremap = true, silent = true }
local function map(mode, key, action, settings)
    vim.api.nvim_set_keymap(mode, key, action, settings or NS)
end

map('',  '<C-H>',     'b')
map('',  '<C-L>',     'w')
map('',  '<S-Down>',  '<S-}>')
map('n', '<Space>',   '<Leader>')
map('n', 'B',         '<cmd>bp<CR>')
map('n', 'N',         '<cmd>bN<CR>')
map('n', '<Leader>d', '"_d')
map('n', '<Leader>c', '"_c')
map('x', '<Leader>d', '"_d')
map('x', '<Leader>c', '"_c')
map('n', '<Leader>o', 'o<Esc>')
map('n', '<Leader>O', 'O<Esc>')
map('i', '<C-BS>',    '<C-W>')
map('i', '<S-Down>',  '<Esc>}i')
map('i', '<S-Up>',    '<Esc>{i')
map('x', '<S-Down>',  '}')
map('x', '<S-Up>',    '{')
map('n', '<S-Down>',  '}')
map('n', '<S-Up>',    '{')
map('n', 'zp',        'vipzf')
map('n', 'yil',       'my^Y`y')
map('n', '<Esc>',     '<cmd>noh<CR>')
map('n', '<Leader>s', '<cmd>w<CR>')

vim.keymap.set('n', 'K',        function() fx.showDocumentation() end, NS)
vim.keymap.set('n', '<C-H>',    function() fx.endCreateLine()     end, NS)
vim.keymap.set('n', '<C-Down>', function() fx.endCreateLine()     end, NS)

