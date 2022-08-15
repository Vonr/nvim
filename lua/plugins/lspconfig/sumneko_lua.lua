local dir = vim.fn.expand('%:p:h')
local opts

if vim.fn.match(dir, '^/home/[^/]+/.config/nvim/') then
    local luadev = require('lua-dev')
    local config = luadev.setup({})
    if not config then
        return
    end

    opts = {
        name = "sumneko_lua",
        cmd = {"lua-language-server"},
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'},
                },
                runtime = config.settings.Lua.runtime,
                workspace = {
                    library = config.settings.Lua.workspace.library,
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        }
    }
else
    opts = {
        name = "sumneko_lua",
        cmd = {"lua-language-server"},
        settings = {
            Lua = {
                telemetry = {
                    enable = false,
                },
                workspace = {
                    checkThirdParty = false,
                },
            },
        }
    }
end

local client_id = vim.lsp.start_client(opts)
if client_id then vim.lsp.buf_attach_client(0, client_id) end
