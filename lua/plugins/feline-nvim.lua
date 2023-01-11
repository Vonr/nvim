return {
    'feline-nvim/feline.nvim',
    config = function()
        local lsp = require('feline.providers.lsp')
        local vi_mode_utils = require('feline.providers.vi_mode')

        local force_inactive = {
            filetypes = {},
            buftypes  = {},
            bufnames  = {}
        }

        local colors = {
            bg = '#282828',
            black = '#282828',
            yellow = '#d8a657',
            cyan = '#89b482',
            oceanblue = '#45707a',
            green = '#a9b665',
            orange = '#e78a4e',
            violet = '#d3869b',
            magenta = '#c14a4a',
            white = '#a89984',
            fg = '#a89984',
            skyblue = '#7daea3',
            red = '#ea6962',
        }

        local vi_mode_colors = {
            NORMAL        = 'green',
            OP            = 'green',
            INSERT        = 'red',
            CONFIRM       = 'red',
            VISUAL        = 'skyblue',
            LINES         = 'skyblue',
            BLOCK         = 'skyblue',
            REPLACE       = 'violet',
            ['V-REPLACE'] = 'violet',
            ENTER         = 'cyan',
            MORE          = 'cyan',
            SELECT        = 'orange',
            COMMAND       = 'green',
            SHELL         = 'green',
            TERM          = 'green',
            NONE          = 'yellow'
        }

        local components = {
            active = {
                {
                    {
                        provider = function()
                            return vi_mode_utils.get_vim_mode()
                        end,
                        hl = function()
                            return {
                                fg = vi_mode_utils.get_mode_color(),
                                bg = 'bg',
                                style = 'bold',
                            }
                        end,
                        right_sep = ' '
                    },

                    {
                        provider = function()
                            return vim.fn.expand("%:F")
                        end,
                        hl = {
                            fg = 'white',
                            bg = 'bg',
                            style = 'bold'
                        },
                    },

                    {
                        provider = 'line_percentage',
                        hl = {
                            fg = 'white',
                            bg = 'bg',
                            style = 'bold'
                        },
                        left_sep = ' '
                    },

                    {
                        provider = 'position',
                        hl = {
                            fg = 'white',
                            bg = 'bg',
                            style = 'bold'
                        },
                        left_sep = ' '
                    }
                },

                {
                    {
                        provider = 'git_branch',
                        hl = {
                            fg = 'yellow',
                            bg = 'bg',
                            style = 'bold'
                        }
                    },

                    {
                        provider = 'git_diff_added',
                        hl = {
                            fg = 'green',
                            bg = 'bg',
                            style = 'bold'
                        }
                    },

                    {
                        provider = 'git_diff_changed',
                        hl = {
                            fg = 'orange',
                            bg = 'bg',
                            style = 'bold'
                        }
                    },

                    {
                        provider = 'git_diff_removed',
                        hl = {
                            fg = 'red',
                            bg = 'bg',
                            style = 'bold'
                        },
                    },

                    {
                        provider = 'diagnostic_errors',
                        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
                        hl = {
                            fg = 'red',
                            style = 'bold'
                        }
                    },

                    {
                        provider = 'diagnostic_warnings',
                        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
                        hl = {
                            fg = 'yellow',
                            style = 'bold'
                        }
                    },

                    {
                        provider = 'diagnostic_hints',
                        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
                        hl = {
                            fg = 'cyan',
                            style = 'bold'
                        }
                    },

                    {
                        provider = 'diagnostic_info',
                        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
                        hl = {
                            fg = 'skyblue',
                            style = 'bold'
                        }
                    }
                },

                {
                    {
                        provider = 'lsp_client_names',
                        hl = {
                            fg = 'yellow',
                            bg = 'bg',
                            style = 'bold'
                        },
                        right_sep = ' '
                    },

                    {
                        provider = function()
                            local filename = vim.fn.expand('%:t')
                            local extension = vim.fn.expand('%:e')
                            local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
                            if icon == nil then
                                icon = ''
                            end
                            return icon
                        end,
                        hl = function()
                            local val = {}
                            local filename = vim.fn.expand('%:t')
                            local extension = vim.fn.expand('%:e')
                            local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
                            if icon ~= nil then
                                val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
                            else
                                val.fg = 'white'
                            end
                            val.bg = 'bg'
                            val.style = 'bold'
                            return val
                        end,
                        right_sep = ' '
                    },

                    {
                        provider = 'file_type',
                        hl = function()
                            local val = {}
                            local filename = vim.fn.expand('%:t')
                            local extension = vim.fn.expand('%:e')
                            local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
                            if icon ~= nil then
                                val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
                            else
                                val.fg = 'white'
                            end
                            val.bg = 'bg'
                            val.style = 'bold'
                            return val
                        end,
                        right_sep = ' '
                    },

                    {
                        provider = 'file_size',
                        enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
                        hl = {
                            fg = 'skyblue',
                            bg = 'bg',
                            style = 'bold'
                        },
                        right_sep = ' '
                    },

                    {
                        provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
                        hl = {
                            fg = 'white',
                            bg = 'bg',
                            style = 'bold'
                        },
                        right_sep = ' '
                    }
                }
            },

            inactive = {
                {
                    {
                        provider = 'file_type',
                        hl = {
                            fg = 'black',
                            bg = 'cyan',
                            style = 'bold'
                        },
                        left_sep = {
                            str = ' ',
                            hl = {
                                fg = 'NONE',
                                bg = 'cyan'
                            }
                        },
                        right_sep = {
                            {
                                str = ' ',
                                hl = {
                                    fg = 'NONE',
                                    bg = 'cyan'
                                }
                            },
                            ' '
                        }
                    }
                },

                {},

                {}
            }
        }

        require('feline').setup({
            theme = colors,
            default_bg = colors.bg,
            default_fg = colors.fg,
            vi_mode_colors = vi_mode_colors,
            components = components,
            force_inactive = force_inactive,
        })
    end,
}
