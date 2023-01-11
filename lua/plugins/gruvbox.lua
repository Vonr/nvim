return {
    'mhdahmad/gruvbox.lua',
    config = function()
        vim.cmd.colorscheme("gruvbox")
        vim.cmd.colorscheme("gruvbox") -- This is not a mistake, for some reason it needs to be loaded twice to be correct
    end,
}
