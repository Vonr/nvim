local filetypes = {
    dart = {
        formatter = 'dartformat',
    },
    c = {
        formatter = 'clangformat',
    },
    cpp = {
        formatter = 'clangformat',
    },
}

local lsps = {
    'svelte',
    'tsserver',
}

return {
    'mhartington/formatter.nvim',
    ft = (function()
        local fts = {}
        for ft, _ in pairs(filetypes) do
            table.insert(fts, ft)
        end

        return fts
    end)(),
    config = function()
        local formatter = require('formatter')

        formatter.setup {
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = (function()
                local formatters = {}
                for ft, fmt in pairs(filetypes) do
                    table.insert(formatters, require('formatter.filetypes.' .. ft)[fmt])
                end

                return formatters
            end)(),
        }
    end,
    init = function()
        vim.api.nvim_create_autocmd('BufWritePost', {
            callback = function()
                if filetypes[vim.bo.filetype] ~= nil then
                    vim.cmd('FormatWrite')
                else
                    for _, client in ipairs(vim.lsp.get_active_clients()) do
                        local capabilities = client.config.capabilities.textDocument
                        if not capabilities or not capabilities.formatting then
                            return
                        end

                        for _, lsp_name in ipairs(lsps) do
                            if client.name == lsp_name then
                                vim.lsp.buf.format()
                                return
                            end
                        end
                    end
                end
            end
        })
    end
}
