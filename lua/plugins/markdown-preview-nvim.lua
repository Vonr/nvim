return {
    'iamcco/markdown-preview.nvim',
    ft = { "markdown" },
    run = function()
        vim.fn["mkdp#util#install"]()
    end,
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
}
