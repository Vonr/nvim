local client_id = vim.lsp.start_client({
    name = "gopls",
    cmd = {"gopls"},
})

require'go'.setup({
    lsp_inlay_hints = {
        enable = true,
    }
})

vim.lsp.buf_attach_client(0, client_id)
