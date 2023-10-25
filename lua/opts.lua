local b           = vim.b
local g           = vim.g
local wo          = vim.wo
local bo          = vim.bo
local opt         = vim.opt

-- Vim Globals
g.mapleader       = ' '
g.belloff         = 'all'
g.undodir         = vim.fn.stdpath('cache') .. '/undodir'
g.incsearch       = true
g.autowrite       = true
g.lazyredraw      = true
g.backup          = false
opt.swapfile      = false
opt.termguicolors = true

---@type 'kanagawa' | 'gruvbox'
vim.g.colors_name = 'kanagawa'

local links       = {
    ['@lsp.type.namespace'] = '@namespace',
    ['@lsp.type.type'] = '@type',
    ['@lsp.type.class'] = '@type',
    ['@lsp.type.enum'] = '@type',
    ['@lsp.type.interface'] = '@type',
    ['@lsp.type.struct'] = '@structure',
    ['@lsp.type.parameter'] = '@parameter',
    ['@lsp.type.variable'] = '@variable',
    ['@lsp.type.property'] = '@property',
    ['@lsp.type.enumMember'] = '@constant',
    ['@lsp.type.function'] = '@function',
    ['@lsp.type.method'] = '@method',
    ['@lsp.type.macro'] = '@macro',
    ['@lsp.type.decorator'] = '@function',
}
for newgroup, oldgroup in pairs(links) do
    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

opt.clipboard = 'unnamedplus'
opt.guifont = 'FantasqueSansM Nerd Font:h12'

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
opt.iskeyword = '@,48-57,_,192-255'


-- Vim Buffer-specifics
function vim.bset(name, value)
    bo[name], b[name] = value, value
end

local bset = vim.bset

b.mapleader = ' ' -- mapleader is not in vim.bo
bset('autoindent', true)
bset('undofile', true)
bset('smartindent', true)
bset('cindent', true)

-- Vim Window-specifics
wo.number         = true
wo.relativenumber = true
wo.signcolumn     = 'number'
wo.wrap           = false
wo.sidescrolloff  = 10
wo.scrolloff      = 6
