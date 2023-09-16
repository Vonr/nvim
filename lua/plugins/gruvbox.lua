return {
    'mhdahmad/gruvbox.lua',
    enabled = vim.g.colors_name == 'gruvbox',
    config = function()
        vim.cmd.colorscheme('gruvbox')
    end
}
