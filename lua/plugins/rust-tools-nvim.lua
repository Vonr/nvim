return {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
    config = function()
        local opts = {
            tools = {
                autoSetHints = true,
                executor = require("rust-tools/executors").termopen,
                on_initialized = nil,
                inlay_hints = {
                    auto = true,
                },
            },
            server = {
                cmd = { "rust-analyzer" },
                root_dir = require'lspconfig.util'.root_pattern('Cargo.toml'),
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
                                '-W', 'clippy::nursery',
                                '-D', 'clippy::correctness',
                                '-D', 'clippy::complexity',
                                '-D', 'clippy::perf',
                                '-D', 'clippy::style',
                            }
                        }
                    }
                }
            }
        }

        vim.g.rustfmt_autosave = 1

        vim.api.nvim_set_keymap("n", "<S-K>", "<cmd>RustHoverActions<CR>", { noremap = true, silent = true })

        require('rust-tools').setup(opts)
    end,
}
