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

return require('lazy').setup('plugins/', {
    change_detection = {
        enabled = true,
        notify = false,
    },
    performance = {
        reset_packpath = true,
        rtp = {
            reset = true,
            paths = {},
            disabled_plugins = {
                'netrw',
                'netrwPlugin',
                'netrwSettings',
                'netrwFileHandlers',
                'gzip',
                'zip',
                'zipPlugin',
                'tar',
                'tarPlugin',
                'tutor_mode_plugin',
                'getscript',
                'getscriptPlugin',
                'vimball',
                'vimballPlugin',
                '2html_plugin',
                'logipat',
                'rrhelper',
                'spellfile_plugin',
                'matchit'
            },
        },
    },
    profiling = {
        loader = false,
        require = true,
    },
})
