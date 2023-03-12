return {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function()
        local crates = require'crates'
        crates.setup()
        crates.show()
        require'cmp'.setup.buffer({ sources = { { name = "crates" } } })
    end
}
