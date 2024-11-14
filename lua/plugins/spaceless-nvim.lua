return {
    'svranesevic/spaceless.nvim',
    event = 'BufRead',
    config = function()
        require 'spaceless'.setup({
            ignore_filetypes = {
                'markdown',
            }
        })
    end
}
