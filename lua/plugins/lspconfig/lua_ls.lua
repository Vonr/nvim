return {
    name = "lua_ls",
    filetype = { 'lua' },
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            telemetry = {
                enable = false,
            },
            runtime = {
                version = 'LuaJIT',
                path = {
                    '?.lua',
                    '?/init.lua',
                    vim.env.HOME .. '/.luarocks/share/lua/5.4/?.lua',
                    vim.env.HOME .. '/.luarocks/share/lua/5.4/?/init.lua',
                    '/usr/share/5.4/?.lua',
                    '/usr/share/lua/5.4/?/init.lua'
                }
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.HOME .. '/.local/share/luals_libs',
                    vim.env.HOME .. '/.luarocks/share/lua/5.4'
                },
            },
        },
    },
    auto_attach = false,
}
