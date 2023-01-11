return {
    'anuvyklack/hydra.nvim',
    lazy = true,
    keys = {
        {'<Leader>f', mode = 'n'}
    },
    config = function()
        local Hydra = require'hydra'
        local function cmd(c) return function() vim.cmd(c) end end

        Hydra({
            name = 'Commands',
            hint = [[Useful commands]],
            mode = 'n',
            body = '<Leader>f',
            config = {
                exit = true,
            },
            heads = {
                { 't', function() vim.cmd[[ter]]; vim.api.nvim_feedkeys('i', 'n', false) end, { desc = [[Opens a new terminal]] } },
                { 'r', cmd[[:!%]], { desc = [[Runs the current file without terminal]] } },
                { 'R', cmd[[ter %]], { desc = [[Runs the current file in terminal]] } },
                { 'd', cmd[[:!dragon-drop %]], { desc = [[Runs dragon-drop on current file]] } },
            }
        })
    end
}
