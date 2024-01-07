return {
    'mrcjkb/rustaceanvim',
    version = '^3',
    ft = { 'rust' },
    init = function()
        vim.api.nvim_create_autocmd('BufReadPre', {
            pattern = '*.rs',
            callback = function()
                local opts = {
                    tools = {
                        autoSetHints = true,
                        on_initialized = function(_)
                            vim.lsp.inlay_hint.enable()
                            vim.notify("rust-analyzer started")
                        end,
                        runnables = {
                            use_telescope = true
                        },
                    },
                    server = {
                        cmd = { 'rust-analyzer' },
                        root_dir = require('lspconfig.util').root_pattern('Cargo.toml'),
                        standalone = true,
                        settings = {
                            ['rust-analyzer'] = {
                                checkOnSave = {
                                    allFeatures = true,
                                    overrideCommand = {
                                        'cargo', 'clippy',
                                        '--workspace',
                                        '--message-format=json',
                                        '--all-targets',
                                        '--all-features',
                                        '--',
                                        '-D', 'clippy::correctness',
                                        '-D', 'clippy::complexity',
                                        '-D', 'clippy::perf',
                                        '-D', 'clippy::style',
                                    }
                                },
                                cargo = {
                                    buildScripts = true,
                                    allFeatures = true,
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
                                            ['Is Not Empty'] = {
                                                postfix = { 'nmt', 'is_not_empty' },
                                                body = '!${receiver}.is_empty()',
                                                scope = 'expr',
                                            },
                                            ['Is Empty'] = {
                                                postfix = { 'mt', 'is_empty' },
                                                body = '${receiver}.is_empty()',
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
                                        }
                                    }
                                }
                            }
                        }
                    },
                }

                vim.g.rustfmt_autosave = 1

                vim.api.nvim_set_keymap("n", "<S-K>", "<cmd>RustLsp hover actions<CR>", { noremap = true, silent = true })

                vim.g.rustaceanvim = opts
            end
        })
    end,
}
