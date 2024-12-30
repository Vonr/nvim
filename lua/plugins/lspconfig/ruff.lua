return function(opts)
    opts.on_attach = function(args)
        local client = vim.lsp.get_client_by_id(args.client_id)
        if client == nil then
            return
        end
        if client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
        end
    end

    return opts
end
