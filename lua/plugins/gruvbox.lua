return {
    'mhdahmad/gruvbox.lua',
    cond = vim.g.colors_name == 'gruvbox',
    event = 'UIEnter',
    config = function()
        vim.cmd.colorscheme('gruvbox')
    end
}
