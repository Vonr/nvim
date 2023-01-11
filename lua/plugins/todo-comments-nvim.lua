return {
    'folke/todo-comments.nvim',
    cmd = {
        'TodoLocList',
        'TodoQuickFix',
        'TodoTrouble',
        'TodoTelescope',
    },
    config = function()
        require'todo-comments'.setup{}
    end,
}
