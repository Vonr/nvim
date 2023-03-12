--[[
--  This file contains non-plugin-specific global or replacement
--  functions to be called from elsewhere in the config.
--]]

local M = {}

M.show_documentation = function()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim', 'help' }, filetype) then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({ 'man' }, filetype) then
        vim.cmd('Man ' .. vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' then
        require('crates').show_popup()
    else
        vim.lsp.buf.signature_help()
    end
end

M.end_create_line = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    if vim.api.nvim_call_function("line", { "$" }) == cursor[1] then
        vim.api.nvim_input('o<Esc>')
    else
        vim.api.nvim_input('<C-d>zz')
    end
end

local old_nvim_cmd = vim.api.nvim_cmd
vim.api.nvim_cmd = function(command, opt)
    return old_nvim_cmd(command, opt or {})
end

M.capture = function(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

return M
