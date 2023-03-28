local fx = require'functions'

return {
    name = "hls",
    filetype = { "haskell" },
    cmd = {"haskell-language-server-wrapper", "--lsp"},
    on_init = function()
        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local conf = require("telescope.config").values
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        _G.pointfree = function(opts)
            opts = opts or {}
            if vim.bo.filetype ~= 'haskell' then
                return
            end
            local curline = vim.fn.getline('.')
            local spaces = curline:match('^%s+') or ""

            coroutine.wrap(function()
                pickers.new(opts, {
                    prompt_title = "Pointfree",
                    finder = finders.new_table {
                        results = fx.string_split(fx.capture([[pointfree -v "]] .. vim.fn.escape(curline, '"') .. [[" | tail -n +4]], true), "\n")
                    },
                    sorter = conf.generic_sorter(opts),
                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local selected = action_state.get_selected_entry()
                            if #selected ~= 0 then
                                vim.api.nvim_set_current_line(spaces .. selected[1])
                            end
                        end)
                        return true
                    end,
                }):find()
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
    end
}
