return {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { 'rust' },
    init = function()
        ---@type rustaceanvim.Config
        vim.g.rustaceanvim = {
            ---@type rustaceanvim.tools.Config
            tools = {
                on_initialized = function(_)
                    -- vim.lsp.inlay_hint.enable()
                    vim.notify("rust-analyzer started")
                end,
            },
            ---@type rustaceanvim.lsp.ClientConfig
            server = {
                cmd = { 'rust-analyzer' },
                auto_attach = true,
                standalone = true,
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = true,
                        check = {
                            enable = true,
                            features = 'all',
                            allTargets = true,
                            overrideCommand = {
                                'cargo', 'clippy',
                                '--workspace',
                                '--message-format=json',
                                '--all-targets',
                                '--',
                                '-D', 'clippy::correctness',
                                '-D', 'clippy::complexity',
                                '-D', 'clippy::perf',
                                '-D', 'clippy::style',
                            },
                        },
                        cargo = {
                            buildScripts = {
                                enable = true
                            },
                            features = 'all',
                        },
                        procMacro = {
                            enable = true,
                        },
                        completion = {
                            snippets = {
                                custom = {
                                    ['Collect into Vec'] = {
                                        postfix = 'cv',
                                        body = '${receiver}.collect::<Vec<_>>()',
                                        description = 'Collects iterator into a Vec of an inferred type.',
                                        scope = 'expr',
                                    },
                                    ['Collect'] = {
                                        postfix = 'cl',
                                        body = '${receiver}.collect::<$1>()',
                                        description = 'Collects iterator into a Vec of an inferred type.',
                                        scope = 'expr',
                                    },
                                    ['Filter Map Results'] = {
                                        postfix = 'oks',
                                        body = '${receiver}.filter_map(Result::ok)',
                                        description =
                                        'Filters an iterator of Results to Ok variants and maps it to its inner type.',
                                        scope = 'expr',
                                    },
                                    ['Wrap with new'] = {
                                        postfix = 'new',
                                        body = '$1::new(${receiver})$0',
                                        scope = 'expr',
                                    },
                                    ['Drop'] = {
                                        postfix = 'drop',
                                        body = 'drop(${receiver})',
                                        scope = 'expr',
                                    },
                                    ['Clone Self'] = {
                                        postfix = 'clsf',
                                        body = 'let ${receiver} = ${receiver}.clone();$1',
                                        scope = 'expr',
                                    },
                                }
                            }
                        }
                    }
                }
            },
        }

        vim.g.rustfmt_autosave = 1

        vim.api.nvim_create_autocmd('BufReadPre', {
            pattern = '*.rs',
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                local set = { noremap = true, silent = true, buffer = buf }

                local rlsp = function(options)
                    return function() vim.cmd.RustLsp(options) end
                end

                vim.keymap.set('n', '<S-K>', rlsp({ 'hover', 'actions' }), set)
                vim.keymap.set('n', '<Leader>xm', rlsp('expandMacro'), set)
                vim.keymap.set('n', '<Leader>xc', rlsp('openCargo'), set)
                vim.keymap.set('n', '<Leader>xd', rlsp('externalDocs'), set)
                vim.keymap.set('n', '<Leader>xe', rlsp('explainError'), set)
                vim.keymap.set('n', '<Leader>xp', rlsp('rebuildProcMacros'), set)
                vim.keymap.set('n', '<Leader>xr', rlsp('reloadWorkspace'), set)
                vim.keymap.set('n', '<Leader>xM', rlsp({ 'view', 'mir' }), set)
                vim.keymap.set('n', '<Leader>xh', rlsp({ 'view', 'hir' }), set)
                vim.keymap.set('n', '<Leader>xD', rlsp('debuggables'), set)
                vim.keymap.set('n', '<Leader>xR', rlsp('runnables'), set)
            end
        })
    end
}
