local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
    cmd = {
        vim.env.HOME .. '/.config/nvim/lua/plugins/lspconfig/jdtls.sh',
        vim.env.HOME .. '/.cache/jdtls/' .. project_name,
    },

    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    settings = {
        java = {
            inlayHints = {
                parameterNames = true
            }
        }
    },

    handlers = {
        ['language/status'] = function() end
    },

    init_options = {
        bundles = {}
    },
}

vim.api.nvim_create_autocmd({'BufEnter'}, {
    pattern = { '*.java' },
    callback = function()
        require('jdtls').start_or_attach(config)
    end
})
