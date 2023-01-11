vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

_G.load_luasnip = function()
    _G.luasnip = require'luasnip'
    require'cmp-luasnip'
    _G.load_luasnip = function() return _G.luasnip end
    return _G.luasnip
end

return require'lazy'.setup('plugins')
