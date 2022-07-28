local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("mzs.lsp.handlers").on_attach,
		capabilities = require("mzs.lsp.handlers").capabilities,
    }

    if server.name == "sumneko_lua" then
        --opts = {
            --settings = {
                --Lua = {
                    --diagnostics = {
                        --globals = { 'vim', 'use' }
                    --},
                    --workspace = {
                     --Make the server aware of Neovim runtime files
                    --library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
                    --}
                --}
            --}
        --}
        local sumneko_opts = require("mzs.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "jsonls" then
        local jsonls_opts = require("mzs.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server.name == "pyright" then
        local pyright_opts = require("mzs.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end


    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
