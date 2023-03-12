return {
    'ray-x/go.nvim',
    ft = {'go'},
    dependencies = { 'ray-x/guihua.lua' },
    config = function()
        vim.g.go_metalinter_enabled  = {'vet', 'golint', 'errcheck'}
        vim.g.go_metalinter_autosave = 1
        vim.g.go_metalinter_deadline = "5s"
    end
}
