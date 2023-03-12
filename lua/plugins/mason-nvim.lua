return {
    'williamboman/mason.nvim',
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
            'williamboman/mason-lspconfig.nvim',
            config = true,
        },
    }
}
