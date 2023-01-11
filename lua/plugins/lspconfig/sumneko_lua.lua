return {
    name = "sumneko_lua",
    filetype = { 'lua' },
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'},
            },
            runtime = _G.luadev_config and _G.luadev_config.settings.Lua.runtime or {},
            workspace = {
                library = _G.luadev_config and _G.luadev_config.settings.Lua.workspace.library or {},
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
    before_init = function()
        local dir = vim.fn.expand('%:p:h')
        if vim.fn.match(dir, '^/home/[^/]+/.config/nvim/') then
            local luadev = require('lua-dev')
            _G.luadev_config = luadev.setup({})
        end
    end
}

