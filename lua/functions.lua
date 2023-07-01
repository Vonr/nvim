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

M.string_split = function(str, delim)
    delim = delim or "%s"
    local t = {}
    for match in string.gmatch(str, "([^" .. delim .. "]+)") do
        table.insert(t, match)
    end
    return t
end

return M
