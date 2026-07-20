return {
    'mason-org/mason.nvim',
    cmd = {
        'Mason',
        'MasonInstall',
        'MasonLog',
        'MasonUninstall',
        'MasonUninstallAll',
    },
    config = true,
    dependencies = {
        {
            'mason-org/mason-lspconfig.nvim',
            config = true,
        },
    }
}
