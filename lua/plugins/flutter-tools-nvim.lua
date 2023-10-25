return {
    'akinsho/flutter-tools.nvim',
    ft = { 'dart' },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
    },
    config = function()
        require('flutter-tools').setup({
            debugger = {
                enabled = true,
                run_via_dap = true,
                exception_breakpoints = {},
                register_configurations = function(paths)
                    local dap = require('dap')

                    dap.adapters.dart = {
                        type = 'executable',
                        command = vim.fn.stdpath('data') .. '/mason/packages/dart-debug-adapter/dart-debug-adapter',
                        args = { 'flutter' }
                    }
                    dap.configurations.dart = {
                        {
                            type = 'dart',
                            request = 'launch',
                            name = 'Launch flutter',
                            dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/',
                            flutterSdkPath = '/opt/flutter',
                            program = '${workspaceFolder}/lib/main.dart',
                            cwd = '${workspaceFolder}',
                        }
                    }
                end,
            },
            lsp = {
                capabilities = function()
                    local out = vim.lsp.protocol.make_client_capabilities()
                    out = require('cmp_nvim_lsp').default_capabilities(out)
                    out.semanticTokensProvider = nil
                    out.textDocument.codeAction = {
                        dynamicRegistration = false,
                        codeActionLiteralSupport = {
                            codeActionKind = {
                                valueSet = {
                                    "",
                                    "quickfix",
                                    "refactor",
                                    "refactor.extract",
                                    "refactor.inline",
                                    "refactor.rewrite",
                                    "source",
                                    "source.organizeImports",
                                }
                            }
                        }
                    }
                    return out
                end,
                init_options = {
                    onlyAnalyzeProjectsWithOpenFiles = true,
                    suggestFromUnimportedLibraries = false,
                    closingLabels = true,
                },
            }
        })

        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = { '*.dart' },
            callback = function()
                vim.lsp.buf.format()
                vim.notify('tried to format')
            end
        })
    end
}
