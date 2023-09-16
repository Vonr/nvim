return {
    'simrat39/rust-tools.nvim',
    event = { "BufReadPre *.rs" },
    config = function()
        local lldb_ext = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
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
                root_dir = require'lspconfig.util'.root_pattern('Cargo.toml'),
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
                                    ['let Some else'] = {
                                        postfix = 'lse',
                                        prefix = 'lse',
                                        body = 'let Some($1) = ${receiver} else {\n\t$2\n}',
                                        scope = 'expr',
                                    },
                                    ['if let Some'] = {
                                        postfix = 'ils',
                                        prefix = 'ils',
                                        body = 'if let Some($1) = ${receiver} {\n\t$2\n}',
                                        scope = 'expr',
                                    },
                                    ['let Ok else'] = {
                                        postfix = 'loe',
                                        prefix = 'loe',
                                        body = 'let Ok($1) = ${receiver} else {\n\t$2\n}',
                                        scope = 'expr',
                                    },
                                    ['if let Ok'] = {
                                        postfix = 'ilo',
                                        prefix = 'ilo',
                                        body = 'if let Ok($1) = ${receiver} {\n\t$2\n}',
                                        scope = 'expr',
                                    },
                                    ['Match Option'] = {
                                        postfix = 'mo',
                                        body = 'match ${receiver} {\n\tSome(inner) => {\n\t\t$2\n\t},\n\tNone => {\n\t\t$3\n\t},\n}',
                                        scope = 'expr',
                                    },
                                    ['Match Result'] = {
                                        postfix = 'mr',
                                        body = 'match ${receiver} {\n\tOk(inner) => {\n\t\t$2\n\t},\n\tErr(e) => {\n\t\t$3\n\t},\n}',
                                        scope = 'expr',
                                    },
                                    ['const'] = {
                                        postfix = 'const',
                                        prefix = 'const',
                                        body = '|_| ${receiver}',
                                        description = 'Turns an expression into a closure that voids an input and returns the result of that expression.',
                                        scope = 'expr',
                                    },
                                    ['Move const'] = {
                                        postfix = 'mconst',
                                        prefix = 'mconst',
                                        body = 'move |_| ${receiver}',
                                        description = 'Turns an expression into a move closure that voids an input and returns the result of that expression.',
                                        scope = 'expr',
                                    },
                                    ['Closure'] = {
                                        postfix = 'cls',
                                        body = '|| ${receiver}',
                                        description = 'Creates a closure from an expression.',
                                        scope = 'expr',
                                    },
                                    ['Move Closure'] = {
                                        postfix = 'mcls',
                                        body = 'move || ${receiver}',
                                        description = 'Creates a move closure from an expression.',
                                        scope = 'expr',
                                    },
                                    ['Derive'] = {
                                        prefix = 'der',
                                        body = '#[derive($0)]',
                                        scope = 'item',
                                    },
                                    ['Is Not Empty'] = {
                                        postfix = {'nmt', 'is_not_empty'},
                                        body = '!${receiver}.is_empty()',
                                        scope = 'expr',
                                    },
                                    ['Is Empty'] = {
                                        postfix = {'mt', 'is_empty'},
                                        body = '${receiver}.is_empty()',
                                        scope = 'expr',
                                    },
                                    ['into_iter'] = {
                                        postfix = 'iit',
                                        body = '${receiver}.into_iter()',
                                        scope = 'expr',
                                    },
                                    ['Wrap with new'] = {
                                        postfix = 'wrn',
                                        body = '$1::new(${receiver})$0',
                                        scope = 'expr',
                                    },
                                    ['Forget'] = {
                                        postfix = 'forget',
                                        body = 'forget(${receiver})',
                                        requires = 'std::mem::forget',
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
