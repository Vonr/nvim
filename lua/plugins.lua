return require'packer'.startup{
    function(use)
        use {
            'lewis6991/impatient.nvim',
            {
                'wbthomason/packer.nvim',
                opt = true
            },
            {
                'mhdahmad/gruvbox.lua',
                config = function()
                    vim.api.nvim_cmd({
                        cmd = "colorscheme",
                        args = { "gruvbox" },
                    })
                end,
            },
            {
                'mbbill/undotree',
                cmd = {
                    'UndotreeToggle',
                    'UndotreeFocus',
                    'UndotreeHide',
                    'UndotreeShow',
                },
                setup = function()
                    require'plugins/undotree'
                end,
            },
            {
                'feline-nvim/feline.nvim',
                config = function()
                    require'plugins/feline'
                end,
            },
            'kyazdani42/nvim-web-devicons',
            'lewis6991/gitsigns.nvim',
            {
                'nvim-treesitter/nvim-treesitter',
                setup = function()
                    require'plugins/nvim-treesitter'
                end,
            },
            'nvim-treesitter/playground',
            {
                'ur4ltz/surround.nvim',
                mappings = { 's' },
                config = function()
                    require"surround".setup { mappings_style = "sandwich" }
                end
            },
            {
                'github/copilot.vim',
                config = function()
                    require'plugins/copilot'
                end,
            },
            {
                'zbirenbaum/copilot.lua',
                event = "InsertCharPre",
                after = "nvim-cmp",
            },
            -- {
            --     "zbirenbaum/copilot-cmp",
            --     after = { "copilot.lua" },
            -- },
            'windwp/nvim-autopairs',
            'lukas-reineke/indent-blankline.nvim',
            {
                'phaazon/hop.nvim',
                config = function()
                    require'plugins/hop'
                end,
            },
            {
                'junegunn/fzf',
                run = './install --bin',
                cond = vim.fn.filereadable(os.getenv('HOME') .. '/.local/share/nvim/site/pack/packer/opt/fzf/bin/fzf-tmux') == 0
            },
            {
                'ibhagwan/fzf-lua',
                opt = true,
                setup = function()
                    require'plugins/fzf'
                end,
            },
            {
                'mfussenegger/nvim-jdtls',
                opt = true,
                config = function()
                    require'plugins/lspconfig/jdtls'
                end,
            },
            {
                'QiBaobin/vim-gradle',
                ft = {'java', 'kotlin', 'scala', 'xml', 'groovy', 'jproperties'}
            },
            {
                'mikelue/vim-maven-plugin',
                ft = {'java', 'kotlin', 'scala', 'xml', 'groovy', 'jproperties'}
            },
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp',
            {
                'L3MON4D3/LuaSnip',
                config = function()
                    vim.schedule(function()
                        require'plugins/luasnip'
                    end)
                end,
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            {
                'jose-elias-alvarez/null-ls.nvim',
                opt = true,
                config = function()
                    require'plugins/lspconfig/null-ls'
                end,
            },
            'ray-x/cmp-treesitter',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            {
                'saecki/crates.nvim',
                event = { "BufRead Cargo.toml" },
                config = function()
                    require('crates').setup()
                end
            },
            {
                'neovim/nvim-lspconfig',
                config = function()
                    require'plugins/lsp'
                end,
            },
            'williamboman/nvim-lsp-installer',
            {
                'lewis6991/spaceless.nvim',
                config = function()
                    require'spaceless'.setup()
                end,
            },
            {
                'numToStr/Comment.nvim',
                keys = {
                    {"n", "gc"},
                    {"v", "gc"},
                    {"n", "gc"},
                    {"v", "gb"},
                },
                config = function()
                    require'Comment'.setup()
                end,
            },
            {
                'lambdalisue/suda.vim',
                cmd = {
                    'SudaRead',
                    'SudaWrite',
                },
                setup = function()
                    require'plugins/suda'
                end,
            },
            'dstein64/vim-startuptime',
            {
                'ethanholz/nvim-lastplace',
                config = function()
                    require'nvim-lastplace'.setup{}
                end,
            },
            {
                'vimwiki/vimwiki',
                cmd = {
                    'VimwikiIndex',
                    'VimwikiDiaryIndex',
                    'VimwikiTabIndex',
                    'VimwikiUISelect',
                },
                setup = function()
                    require'plugins/vimwiki'
                end,
            },
            {
                'iamcco/markdown-preview.nvim',
                ft = [[markdown]],
                run = function()
                    vim.fn["mkdp#util#install"]()
                end,
                setup = function()
                    vim.g.mkdp_filetypes = { "markdown" }
                end,
            },
            {
                'rust-lang/rust.vim',
                ft = {'rust'},
            },
            {
                'simrat39/rust-tools.nvim',
                opt = true,
                config = function()
                    require('plugins/lspconfig/rust-tools')
                end,
            },
            {
                'rmagatti/alternate-toggler',
                cmd = [[ToggleAlternate]],
                setup = function()
                    require'plugins/alternate-toggler'
                end,
            },
            {
                'folke/todo-comments.nvim',
                cmd = {
                    'TodoLocList',
                    'TodoQuickFix',
                    'TodoTrouble',
                    'TodoTelescope',
                },
                config = function()
                    require'todo-comments'.setup{}
                end,
            },
            {
                'goolord/alpha-nvim',
                config = function ()
                    require'alpha'.setup(require'plugins/alpha'.config)
                end
            },
            {
                'jbyuki/venn.nvim',
                opt = true,
                setup = function()
                    require'plugins/venn'
                end,
            },
            -- {
            --     'hood/popui.nvim',
            --     config = function()
            --         vim.ui.select = require"popui.ui-overrider"
            --         vim.ui.input = require"popui.input-overrider"
            --     end,
            --     requires = { 'RishabhRD/popfix' },
            -- },
            {
                'akinsho/bufferline.nvim',
                opt = true,
                setup = function()
                    require'plugins/bufferline'
                end,
            },
            {
                'nvim-neo-tree/neo-tree.nvim',
                branch = "v2.x",
                cmd = {
                    "NeoTreeClose",
                    "NeoTreeFloat",
                    "NeoTreeFloatToggle",
                    "NeoTreeFocus",
                    "NeoTreeFocusToggle",
                    "NeoTreeLogs",
                    "NeoTreePasteConfig",
                    "NeoTreeReveal",
                    "NeoTreeRevealInSplit",
                    "NeoTreeRevealInSplitToggle",
                    "NeoTreeRevealToggle",
                    "NeoTreeSetLogLevel",
                    "NeoTreeShow",
                    "NeoTreeShowInSplit",
                    "NeoTreeShowInSplitToggle",
                    "NeoTreeShowToggle",
                },
                requires = { "MunifTanjim/nui.nvim" },
                setup = function()
                    require'plugins/neotree'
                end,
            },
            {
                'folke/lua-dev.nvim',
                ft = {'lua'},
            },
            {
                'ray-x/go.nvim',
                opt = true,
                requires = { 'ray-x/guihua.lua' },
                config = function()
                    require'plugins/lspconfig/go'
                end,
            },
            {
                '~/.config/nvim/lua/plugins/dev/align.nvim',
                config = function()
                    require'plugins/align'
                end,
            },
            {
                '~/.config/nvim/lua/plugins/dev/foldcus.nvim',
                requires = { 'nvim-treesitter/nvim-treesitter' },
                config = function()
                    require'plugins/foldcus'
                end,
            },
        }
    end,

    config = {
        profile = {
            enable = false
        },
        display = {
            open_fn = require('packer.util').float,
        }
    }
}
