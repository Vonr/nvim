local fx = require'functions'
local client_id = vim.lsp.start_client({
    name = "hls",
    cmd = {"haskell-language-server-wrapper", "--lsp"},
})

vim.bset('tabstop'    , 2)
vim.bset('softtabstop', 2)
vim.bset('shiftwidth' , 2)

_G.point_free = function()
    if vim.bo.filetype ~= 'haskell' then
        return
    end
    local curline = vim.fn.getline('.')
    local spaces = curline:match('^%s+') or ""

    coroutine.wrap(function ()
        local selected = _G.load_fzf_lua().fzf_exec(
            [[pointfree -v "]] .. vim.fn.escape(curline, '"') .. [[" | tail -n +4]],
            {
                prompt = 'Pointfree ⟫ ',
            })
        if selected then
            vim.api.nvim_set_current_line(spaces .. selected[1])
        end
    end)()
end

_G.pointful = function()
    local line = vim.fn.getline('.')
    local spaces = line:match('^%s+') or ""
    local pointful = fx.capture('pointful "' .. vim.fn.escape(line, '"') .. '"', true)
    vim.api.nvim_set_current_line(spaces .. pointful:gsub('\n', ''))
end

vim.api.nvim_create_user_command('Pointfree', 'lua _G.pointfree()', {})
vim.api.nvim_create_user_command('Pointful', 'lua _G.pointful()', {})

vim.lsp.buf_attach_client(0, client_id)
