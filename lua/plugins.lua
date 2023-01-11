vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require'lazy'.setup({
    {
        'mhdahmad/gruvbox.lua',
        config = function()
            vim.cmd.colorscheme("gruvbox")
            vim.cmd.colorscheme("gruvbox") -- This is not a mistake, for some reason it needs to be loaded twice to be correct
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
        init = function()
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
        init = function()
            require'plugins/nvim-treesitter'
        end,
    },
    {
        'nvim-treesitter/playground',
        cmd = { 'TSPlaygroundToggle' },
    },
    {
        'ur4ltz/surround.nvim',
        keys = { {'s', mode = {'n', 'x'}} },
        config = function()
            require"surround".setup { mappings_style = "sandwich" }
        end
    },
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
        cond = vim.fn.filereadable(vim.env.HOME .. '/.local/share/nvim/site/pack/packer/opt/fzf/bin/fzf-tmux') == 0
    },
    {
        'ibhagwan/fzf-lua',
        lazy = true,
        init = function()
            require'plugins/fzf'
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = { 'java' },
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
        lazy = true,
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
        lazy = true,
        config = function()
            require'plugins/lspconfig/null-ls'
        end,
    },
    'ray-x/cmp-treesitter',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
        'tzachar/cmp-tabnine',
        run='./install.sh',
    },
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        config = function()
            require('crates').setup()
        end
    },
    {
        'folke/neodev.nvim',
        ft = {'lua'},
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require'plugins/lsp'
        end,
    },
    {
        'williamboman/nvim-lsp-installer',
        cmd = {
            'LspInstall',
            'LspInstallInfo',
            'LspInstallLog',
        }
    },
    {
        'lewis6991/spaceless.nvim',
        config = function()
            require'spaceless'.setup()
        end,
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            {'gc', mode = {'n', 'x'}},
            {'gb', mode = {'n', 'x'}},
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
        init = function()
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
        init = function()
            require'plugins/vimwiki'
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        ft = { "markdown" },
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
    {
        'rust-lang/rust.vim',
        ft = {'rust'},
    },
    {
        'simrat39/rust-tools.nvim',
        lazy = true,
        config = function()
            require('plugins/lspconfig/rust')
        end,
    },
    {
        'rmagatti/alternate-toggler',
        cmd = [[ToggleAlternate]],
        init = function()
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
        opt = true,
        config = function()
            require'alpha'.setup(require'plugins/alpha-nvim'.config)
        end
    },
    {
        'jbyuki/venn.nvim',
        opt = true,
        init = function()
            require'plugins/venn'
        end,
    },
    {
        'akinsho/bufferline.nvim',
        lazy = true,
        init = function()
            require'plugins/bufferline'
        end,
    },
    {
        "MunifTanjim/nui.nvim",
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
        init = function()
            require'plugins/neotree'
        end,
    },
    {
        'ray-x/go.nvim',
        lazy = true,
        dependencies = { 'ray-x/guihua.lua' },
    },
    {
        'Pocco81/true-zen.nvim',
        cmd = {
            'TZNarrow',
            'TZFocus',
            'TZMinimalist',
            'TZAtaraxis'
        }
    },
    'anuvyklack/hydra.nvim',

    {
        '~/.config/nvim/lua/plugins/dev/align.nvim',
        dev = true,
        config = function()
            require'plugins/align'
        end,
    },
    {
        '~/.config/nvim/lua/plugins/dev/foldcus.nvim',
        dev = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        cmd = {
            'Foldcus'
        },
        config = function()
            require'plugins/foldcus'
        end,
    },
})
