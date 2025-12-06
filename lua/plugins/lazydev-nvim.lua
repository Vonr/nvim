return {
    'folke/lazydev.nvim',
    ft = 'lua',
    lazy = true,
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
