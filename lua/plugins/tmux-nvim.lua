return {
    "aserowy/tmux.nvim",
    keys = {
        { mode = 'n', 'M-h' },
        { mode = 'n', 'M-j' },
        { mode = 'n', 'M-k' },
        { mode = 'n', 'M-l' },
    },
    opts = {
        copy_sync = {
            enable = false,
            redirect_to_clipboard = true,
            sync_clipboard = false,
            sync_registers = true,
            sync_deletes = true,
            sync_unnamed = true,
        },
        navigation = {
            cycle_navigation = true,
            enable_default_keybindings = true,
            persist_zoom = false,
        },
        resize = {
            enable_default_keybindings = false,
            resize_step_x = 1,
            resize_step_y = 1,
        }
    },
}
