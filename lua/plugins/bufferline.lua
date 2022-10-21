local function setup()
    vim.cmd[[PackerLoad bufferline.nvim]]
    local bfl = require'bufferline'
    bfl.setup{}

    vim.keymap.set("n", "b]",  function() bfl.cycle(1)          end, { noremap = true, silent = true })
    vim.keymap.set("n", "]b",  function() bfl.cycle(1)          end, { noremap = true, silent = true })
    vim.keymap.set("n", "[b",  function() bfl.cycle(-1)         end, { noremap = true, silent = true })
    vim.keymap.set("n", "b[",  function() bfl.cycle(-1)         end, { noremap = true, silent = true })
    vim.keymap.set("n", "bb",  function() bfl.pick_buffer()     end, { noremap = true, silent = true })
    vim.keymap.set("n", "bp",  function() bfl.toggle_pin()      end, { noremap = true, silent = true })
    vim.keymap.set("n", "bdc", function() bfl.close_with_pick() end, { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "bdd", "<cmd>bd<CR>", { noremap = true, silent = true })
end

local count = 1
vim.opt.showtabline = 0
vim.api.nvim_create_autocmd('BufAdd', {
    callback = function()
        vim.schedule(function()
            count = count + 1
            if count > 1 and setup then
                vim.opt.showtabline = 2
                setup()
                setup = function() end
            end
        end)
    end,
})

vim.api.nvim_create_autocmd('BufDelete', {
    callback = function()
        vim.schedule(function()
            count = count - 1
            if count < 2 then
                vim.opt.showtabline = 0
            end
        end)
    end,
})
