return {
    'goolord/alpha-nvim',
    lazy = true,
    init = function()
        vim.api.nvim_create_augroup('AlphaLoad', { clear = true })
        vim.api.nvim_create_autocmd({'BufEnter'},{
            group = 'AlphaLoad',
            callback = function()
                if vim.fn.expand('%') == '' then
                    require'alpha'
                end
                vim.api.nvim_clear_autocmds({ group = 'AlphaLoad' })
            end
        })
    end,
    config = function()
        local if_nil = vim.F.if_nil

        local version = vim.version()

        local default_header = {
            type = "text",
            val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "  v" .. version.major .. "." .. version.minor .. "." .. version.patch .. (version.prerelease and " (pre)" or ""),
                "                                                     ",
            },
            opts = {
                position = "center",
                hl = "Type",
                -- wrap = "overflow";
            },
        }

        local footer = {
            type = "text",
            val = "",
            opts = {
                position = "center",
                hl = "Number",
            },
        }

        local leader = "<Leader>"

        --- @param sc string
        --- @param txt string
        --- @param keybind string optional
        --- @param keybind_opts table optional
        local function button(sc, txt, keybind, keybind_opts)
            local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

            local opts = {
                position = "center",
                shortcut = sc,
                cursor = 5,
                width = 50,
                align_shortcut = "right",
                hl_shortcut = "Keyword",
            }
            if keybind then
                keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true })
                opts.keymap = { "n", sc_, keybind, keybind_opts }
            end

            local on_press = function()
                local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
                vim.api.nvim_feedkeys(key or '', 't', false)
            end

            return {
                type = "button",
                val = txt,
                on_press = on_press,
                opts = opts,
            }
        end

        local buttons = {
            type = "group",
            val = {
                button("e", "  Edit buffer", "<cmd>bd<CR>", {}),
                button("n", "➕ New file", "<cmd>lua vim.ui.input({}, function(s) vim.cmd([[e ]] .. s) end)<CR>", {}),
                button("f", "  Find file", "<cmd>lua require'telescope.builtin'.find_files()<CR>", {}),
                button("r", "󰑓  Recently opened files", "<cmd>lua require'telescope.builtin'.oldfiles()<CR>", {}),
                button("w", "📖 Open Vimwiki index", "<cmd>VimwikiIndex<CR>", {}),
                button("u", "⬆  Update plugins", "<cmd>Lazy sync<CR>", {}),
                button("c", "⚙  Configuration", "<cmd>Neotree float ~/.config/nvim<CR>", {}),
                button("q", "❌ Exit Neovim", "<cmd>q<CR>", {}),
            },
            opts = {
                spacing = 1,
            },
        }

        local section = {
            header = default_header,
            buttons = buttons,
            footer = footer,
        }

        local config = {
            layout = {
                { type = "padding", val = 2 },
                section.header,
                { type = "padding", val = 1 },
                section.buttons,
                section.footer,
            },
            opts = {
                margin = 5,
            },
        }

        require'alpha'.setup(config)
    end
}
