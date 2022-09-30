-- Require other modules
require("configs.lsp.lsp-signature")
require("configs.lsp.diagnostics").setup()

-- Function to configure the mappings that will be called when a buffer attaches to a lsp server
local function on_attach(_, bufnr)
    -- Enable completion triggered by <C-X><C-O>
    -- See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Use LSP as the handler for formatexpr.
    --    See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

    -- Configure key mappings
    require("configs.lsp.mappings").setup(bufnr)
end

-- Default lsp opts for all servers
local global_opts = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

-- All the configured servers
local servers = {
    sumneko_lua = require("configs.lsp.servers.sumneko_lua"),
    tailwindcss = {},
    cssls = {},
    html = {},
    emmet_ls = {},
    tsserver = {},
    -- solc = require("configs.lsp.servers.solc"),
    eslint = {},
    solidity_ls = require("configs.lsp.servers.solidity_ls"),
    pylsp = {},
    pyright = {},
    prosemd_lsp = {},
    jsonls = {}
}

local lspconfig = require("lspconfig")

for server_name, _ in pairs(servers) do
    -- Combine global opts with the specific server options defined above
    local combined_opts = vim.tbl_deep_extend("force", global_opts, servers[server_name] or {})

    -- Make capabilities and combine them to the already combined options
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local opts = vim.tbl_deep_extend("force", combined_opts, {capabilities = capabilities})

    lspconfig[server_name].setup(opts)

end
