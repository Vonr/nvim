return {
    'mfussenegger/nvim-dap',
    keys = {
        { 'gB', mode = 'n' }
    },
    cmd = {
        'DapShowLog',
        'DapToggleBreakpoint',
        'DapToggleRepl',
        'RustDebuggables',
    },
    config = function()
        local dap = function() return require('dap') end
        local Hydra = require('hydra')

        Hydra({
            name = 'DAP',
            hint = [[Mappings for nvim-dap]],
            mode = 'n',
            body = 'gB',
            config = {
                exit = true,
                invoke_on_body = true,
            },
            heads = {
                { 'b', dap().toggle_breakpoint, { desc = [[Toggle Breakpoint]] } },
                { 'c', dap().continue,          { desc = [[Continue]] } },
                { 's', dap().step_over,         { desc = [[Step over]] } },
                { 'S', dap().step_into,         { desc = [[Step into]] } },
                { 'r', dap().repl.open,         { desc = [[Open REPL]] } },
            }
        })
    end,
    dependencies = {
        'anuvyklack/hydra.nvim',
    }
}
