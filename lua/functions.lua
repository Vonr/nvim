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
---@diagnostic disable-next-line: duplicate-set-field
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

---@class MappingOptions
---@field noremap          boolean?
---@field silent           boolean?
---@field buffer           boolean?
---@field nowait           boolean?
---@field script           boolean?
---@field expr             boolean?
---@field unique           boolean?
---@field desc             string?
---@field callback         function?
---@field replace_keycodes boolean?

---@class Mapping
---@field mode     string | string[]
---@field key      string | string[]
---@field action   string
---@field settings MappingOptions?

---@param mappings Mapping[]
M.map = function(mappings)
    local NS = { noremap = true, silent = true }
    for _, m in ipairs(mappings) do
        local keys = {} --[[@as string[] ]]
        if type(m.key) ~= 'table' then
            keys = { m.key }
        end

        local modes = {}
        if type(m.mode) ~= 'table' then
            modes = { m.mode }
        end

        --[[@cast modes string[] ]]
        for _, mode in ipairs(modes) do
            --[[@cast keys string[] ]]
            for _, key in ipairs(keys) do
                vim.api.nvim_set_keymap(mode, key, m.action, m.settings or NS)
            end
        end
    end
end

return M
