return {
    name = "lua_ls",
    filetype = { 'lua' },
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            telemetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false
            },
        },
    },
    auto_attach = false,
}
