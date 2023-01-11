return {
    'lambdalisue/suda.vim',
    cmd = {
        'SudaRead',
        'SudaWrite',
    },
    init = function()
        vim.api.nvim_create_user_command('W', 'lua local f = io.open(vim.fn.expand("%:p"), "w"); if f then f:close(); vim.cmd[[w]]; else vim.cmd[[SudaWrite]]; end', {})
        vim.api.nvim_create_user_command('Wq', 'lua local f = io.open(vim.fn.expand("%:p"), "w"); if f then f:close(); vim.cmd[[wq]]; else vim.cmd[[SudaWrite]]; vim.cmd[[q]]; end', {})
    end,
}
