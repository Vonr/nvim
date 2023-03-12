local b   = vim.b
local g   = vim.g
local wo  = vim.wo
local bo  = vim.bo
local opt = vim.opt

-- Vim Globals
g.mapleader   = ' '
g.belloff     = 'all'
g.undodir     = vim.env.HOME .. '/.vim/undodir'
g.incsearch   = true
g.autowrite   = true
g.lazyredraw  = true
g.backup      = false
opt.swapfile  = false
opt.termguicolors = true
opt.clipboard = 'unnamedplus'
opt.guifont = 'FantasqueSansMono Nerd Font:h12'

g.clipboard = {
    name = "xsel",
    copy = {
        ['+'] = "xsel --nodetach -i -b",
        ['"'] = "xsel --nodetach -i -b",
        ['*'] = "xsel --nodetach -i -p",
    },
    paste = {
        ['+'] = "xsel -o -b",
        ['"'] = "xsel -o -b",
        ['*'] = "xsel -o -p",
    },
    cache_enabled = 1,
}

opt.whichwrap = {
    ['<'] = true,
    ['>'] = true,
    ['['] = true,
    [']'] = true,
    h     = true,
    l     = true,
    b     = true,
    s     = true,
}
opt.iskeyword = '@,48-57,$'


-- Vim Buffer-specifics
function vim.bset(name, value)
    bo[name], b[name] = value, value
end
local bset = vim.bset

b.mapleader = ' ' -- mapleader is not in vim.bo
bset('tabstop'    , 4   )
bset('softtabstop', 4   )
bset('shiftwidth' , 4   )
bset('expandtab'  , true)
bset('autoindent' , true)
bset('undofile'   , true)
bset('smartindent', true)
bset('cindent'    , true)

-- Vim Window-specifics
wo.number         = true
wo.relativenumber = true
wo.signcolumn     = 'number'
wo.wrap           = false
wo.sidescrolloff  = 10
wo.scrolloff      = 6
