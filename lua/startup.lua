require'impatient'
require'impatient'.enable_profile()

vim.cmd[[set runtimepath^=~/.vim runtimepath+=~/.vim/after]]
vim.cmd[[let &packpath = &runtimepath]]

vim.o.foldenable = false

local g = vim.g
g.shell                  = '/usr/bin/bash'
g.python_host_skip_check = 1
g.python_host_prog       = '/usr/bin/python2'
g.python3_host_prog      = '/usr/bin/python3'

local disabled_built_ins = {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'tutor_mode_plugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'spellfile_plugin',
    'matchit'
}

for _, plugin in pairs(disabled_built_ins) do
    g['loaded_' .. plugin] = 1
end

