return {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    config = function()
        require'plugins/lspconfig/jdtls'
    end,
}
