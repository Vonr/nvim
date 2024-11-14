_G.getTrimmedExtension = function(path, charsToTrim)
        local idx = string.find(path, "/[^/]*$")
        local filename = string.sub(path, idx + 1)
        return vim.filetype.match({ filename = filename:sub(1, filename:len() - charsToTrim) })
    end,

    ---@diagnostic disable-next-line: redundant-value
    vim.filetype.add({
        extension = {
            gradle  = 'groovy',
            cl      = 'c',
            wgsl    = 'wgsl',
            hlsl    = 'hlsl',
            postcss = 'scss',
            mdx     = 'markdown',
            sfml    = 'sfml'
        },
        filename = {
            ['picom.conf'] = 'yaml',
            ['sxrc']       = 'bash',
            ['.zshrc']     = 'bash',
            ['PKGBUILD']   = 'bash',
            ['.env']       = 'sh',
        },
        pattern = {
            ['.*%.EXAMPLE'] = function(path, _, _)
                return _G.getTrimmedExtension(path, 8)
            end,
            ['.*%.example'] = function(path, _, _)
                return _G.getTrimmedExtension(path, 8)
            end,
            ['.*%.bak'] = function(path, _, _)
                return _G.getTrimmedExtension(path, 4)
            end,
            ['.*%.disabled'] = function(path, _, _)
                return _G.getTrimmedExtension(path, 9)
            end,
        }
    })
