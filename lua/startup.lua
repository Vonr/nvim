package.path             =
    package.path .. ';' ..
    vim.env.HOME .. '/.luarocks/share/lua/5.1/?/init.lua;' ..
    vim.env.HOME .. '/.luarocks/share/lua/5.1/?.lua'

vim.o.foldenable         = false

local g                  = vim.g
g.shell                  = '/usr/bin/dash'
g.python_host_skip_check = 1
g.python_host_prog       = '/usr/bin/python2'
g.python3_host_prog      = '/usr/bin/python3'
g.loaded_ruby_provider   = 0
g.loaded_perl_provider   = 0
