local fx = require'functions'
local NS = { noremap = true, silent = true }
local function map(mode, key, action, settings)
    vim.api.nvim_set_keymap(mode, key, action, settings or NS)
end

local function mmap(mappings)
    for _, m in ipairs(mappings) do
        vim.api.nvim_set_keymap(m.mode, m.key, m.action, m.settings or NS)
    end
end

mmap({
    { mode = 'n', key = '<Space>',   action = '<Leader>'},
    { mode = 'n', key = '<Leader>d', action = '"_d'},
    { mode = 'n', key = '<Leader>c', action = '"_c'},
    { mode = 'n', key = '<Leader>D', action = '"_D'},
    { mode = 'n', key = '<Leader>C', action = '"_C'},
    { mode = 'x', key = '<Leader>d', action = '"_d'},
    { mode = 'x', key = '<Leader>c', action = '"_c'},
    { mode = 'n', key = '<Leader>o', action = 'o<Esc>'},
    { mode = 'n', key = '<Leader>O', action = 'O<Esc>'},
    { mode = 'i', key = '<C-BS>',    action = '<C-W>'},
    { mode = 'i', key = '<C-Down>',  action = '<Esc>}zzi'},
    { mode = 'i', key = '<C-Up>',    action = '<Esc>{zzi'},
    { mode = 'i', key = '<S-Down>',  action = '<Esc>}zzi'},
    { mode = 'i', key = '<S-Up>',    action = '<Esc>{zzi'},
    { mode = 'x', key = '<C-Down>',  action = '}zz'},
    { mode = 'x', key = '<C-Up>',    action = '{zz'},
    { mode = 'x', key = '<S-Down>',  action = '}zz'},
    { mode = 'x', key = '<S-Up>',    action = '{zz'},
    { mode = 'n', key = '<C-Down>',  action = '}zz'},
    { mode = 'n', key = '<C-Up>',    action = '{zz'},
    { mode = 'n', key = '<S-Down>',  action = '}zz'},
    { mode = 'n', key = '<S-Up>',    action = '{zz'},
    { mode = 'n', key = 'zp',        action = 'vipzf'},
    { mode = 'n', key = 'yil',       action = 'my^Y`y'},
    { mode = 'n', key = '<Esc>',     action = '<cmd>noh<CR>'},
    { mode = 'n', key = '<Leader>s', action = '<cmd>w<CR>'},
    { mode = 'n', key = 'bd',        action = '<cmd>bd<CR>'},
    { mode = 'n', key = 'bD',        action = '<cmd>bd!<CR>'},
    { mode = "i", key = '<C-CR>',    action = '<Esc>o'},
    { mode = 'n', key = '<A-j>',     action = ':m .+1<CR>=='},
    { mode = 'n', key = '<A-Down>',  action = ':m .+1<CR>=='},
    { mode = 'n', key = '<A-k>',     action = ':m .-2<CR>=='},
    { mode = 'n', key = '<A-Up>',    action = ':m .-2<CR>=='},
    { mode = 'i', key = '<A-j>',     action = '<Esc>:m .+1<CR>==gi'},
    { mode = 'i', key = '<A-Down>',  action = '<Esc>:m .+1<CR>==gi'},
    { mode = 'i', key = '<A-k>',     action = '<Esc>:m .-2<CR>==gi'},
    { mode = 'i', key = '<A-Up>',    action = '<Esc>:m .-2<CR>==gi'},
    { mode = 'v', key = '<A-j>',     action = ":m '>+1<CR>gv=gv"},
    { mode = 'v', key = '<A-Down>',  action = ":m '>+1<CR>gv=gv"},
    { mode = 'v', key = '<A-k>',     action = ":m '<-2<CR>gv=gv"},
    { mode = 'v', key = '<A-Up>',    action = ":m '<-2<CR>gv=gv"},
})


vim.keymap.set('n', 'K', fx.show_documentation, NS)
