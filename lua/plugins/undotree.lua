vim.api.nvim_set_keymap('n', '<F5>', '<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>', { noremap = true, silent = true})

if vim.fn.has("persistent_undo") then
    local target_path = vim.fn.expand(os.getenv("HOME") .. '/.vim/undodir')
    if vim.fn.isdirectory(target_path) == 0 then
        os.execute('mkdir -p -m=700 ' .. target_path)
    end
    vim.g.undodir = target_path
end
