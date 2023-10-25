return {
    'simrat39/rust-tools.nvim',
    event = { "BufReadPre *.rs" },
    config = function()
        local lldb_ext = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
        local opts = {
            tools = {
                autoSetHints = true,
                executor = require("rust-tools/executors").termopen,
                on_initialized = function(_) vim.notify("rust-analyzer started") end,
                inlay_hints = {
                    auto = true,
                },
                runnables = {
                    use_telescope = true
                },
            },
            server = {
                cmd = { "rust-analyzer" },
                root_dir = require 'lspconfig.util'.root_pattern('Cargo.toml'),
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
            dap = {
                adapter = require('rust-tools.dap').get_codelldb_adapter(
                    lldb_ext .. 'adapter/codelldb',
                    lldb_ext .. 'lldb/lib/liblldb.so'
                )
            },
        }

        vim.g.rustfmt_autosave = 1

        vim.api.nvim_set_keymap("n", "<S-K>", "<cmd>RustHoverActions<CR>", { noremap = true, silent = true })

        require('rust-tools').setup(opts)
    end,
}
