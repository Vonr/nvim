local foldcus = require('foldcus')
local NS = { noremap = true, silent = true }

vim.keymap.set('n', 'z;', function() foldcus.fold(4)   end, NS)
vim.keymap.set('n', 'z;', function() foldcus.unfold(4) end, NS)
vim.api.nvim_create_user_command('Foldcus',   function(args) foldcus.fold(tonumber(args.args))   end, { nargs = '*' })
vim.api.nvim_create_user_command('Unfoldcus', function(args) foldcus.unfold(tonumber(args.args)) end, { nargs = '*' })
