return {
    name = "gopls",
    filetype = { "go" },
    cmd = {"gopls"},
    on_init = function()
        require'go'.setup({
            lsp_inlay_hints = {
                enable = true,
            }
        })
    end
}
