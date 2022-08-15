local fx = require'functions'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local config = {
    cmd = {
        '/usr/lib/jvm/java-17-graalvm-ee/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', '/usr/share/java/jdtls/plugins/' .. fx.capture('ls /usr/share/java/jdtls/plugins | grep launcher_'),
        '-configuration', '/usr/share/java/jdtls/config_linux',
        '-data', os.getenv('HOME') .. '/.cache/jdtls/' .. project_name
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See { https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request }
    settings = {
        java = {
            inlayhints = {
                parameterNames = true
            }
        }
    },

    handlers = {
        ['language/status'] = function() end
    },
}

require('jdtls').start_or_attach(config)
