return {
    name = "lua_ls",
    filetype = { 'lua' },
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            telemetry = {
                enable = false,
            },
        },
    },
    before_init = function() return require("neodev.lsp").before_init() end,
}
