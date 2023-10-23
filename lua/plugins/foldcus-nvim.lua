return {
    dir = '~/.config/nvim/lua/plugins/dev/foldcus.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    init = function()
        local foldcus = function() return require('foldcus') end

        vim.api.nvim_create_user_command('Foldcus',   function(args) foldcus().fold(tonumber(args.args))   end, { nargs = '*' })
        vim.api.nvim_create_user_command('Unfoldcus', function(args) foldcus().unfold(tonumber(args.args)) end, { nargs = '*' })
    end,
}

