function install_servers(on_attach, capabilities)
  local servers = {
    sqlls = {},
    clangd = {},
    pyright = {},
    html = { filetypes = { 'html', 'twig', 'hbs', 'vuels' } },
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
    volar = {}
  }

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end
  }

end

function on_attach(_, bufnr)
  local keymap = vim.keymap.set

  keymap('n', '<leader>ra', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
  keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
  keymap('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
  keymap('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
  keymap('n', 'gI', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation' })
  keymap('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
  keymap('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
  keymap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    { desc = '[W]orkspace [S]ymbols' })
  keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
  -- Lesser used LSP functionality
  keymap('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
  keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
  keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
  keymap('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    { desc = '[W]orkspace [L]ist Folders' })

end

return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'williamboman/mason.nvim',
      config = true
    },
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {}
    },
    'folke/neodev.nvim',
  },
  config = function()
    -- Setup neovim lua configuration
    require('neodev').setup()

    -- configure diagnostics (should this be here?)
    vim.diagnostic.config({
      underline = false,
      virtual_text = false,
      float = {
        show_header = true,
        source = 'if_many',
        focusable = false
      }
    })

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- disable formatting in favour of a standalone formatter
    capabilities.documentFormattingProvider = false
    capabilities.documentRangeFormattingProvider = false

    -- This is ugly, will make it better someday
    -- require 'lspconfig'.volar.setup {
    --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    --   init_options = {
    --     typescript = {
    --       tsdk = vim.fn.expand '~' .. '.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib'
    --     }
    --   }
    -- }

      install_servers(on_attach, capabilities)
    end
  }
