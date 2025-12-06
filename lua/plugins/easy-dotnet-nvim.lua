---@diagnostic disable: missing-fields
return {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
    ft = { 'cs' },
    config = function()
        local dotnet = require("easy-dotnet")

        dotnet.setup({
            lsp = {
                enabled = true,
                roslynator_enabled = true,
                analyzer_assemblies = {
                    vim.env.HOME .. '/.local/share/Steam/steamapps/common/tModLoader/Libraries/tModCodeAssist/1.0.0/',
                },
                config = {
                    RoslynExtensionsOptions = {
                        enableDecompilationSupport = true
                    }
                },
            },
            debugger = {
                bin_path = nil,
                auto_register_dap = true,
                mappings = {
                    open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
                },
            },
            ---@type TestRunnerOptions
            test_runner = {
                noBuild = true,
                additional_args = {}
            },
            server = {
                log_level = 'Error',
            },
            picker = "telescope",
            notifications = {
                handler = false
            },
        })

        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = '*.cs',
            callback = function()
                vim.api.nvim_create_user_command('Secrets', function()
                    dotnet.secrets()
                end, {})
            end
        })
    end
}
