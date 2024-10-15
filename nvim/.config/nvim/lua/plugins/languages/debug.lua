return {
  'mfussenegger/nvim-dap',
  lazy = false,
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mxsdev/nvim-dap-vscode-js',
    -- lazy spec to build "microsoft/vscode-js-debug" from source
    {
      'microsoft/vscode-js-debug',
      version = '1.x',
      build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
    },
  },
  cmd = 'Debug',
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    local keymap = vim.keymap.set

    -- Basic debugging keymaps
    keymap('n', '<leader>n', dap.continue, { desc = 'Debug: Start/Continue' })
    keymap('n', '<leader>i', dap.step_into, { desc = 'Debug: Step Into' })
    keymap('n', '<leader>o', dap.step_over, { desc = 'Debug: Step Over' })
    keymap('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    keymap('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    keymap('n', '<leader>t', dapui.toggle, { desc = 'Debug: See last session result.' })

    -- Dap UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.5,
            },
            {
              id = 'watches',
              size = 0.5,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = { {
            id = 'repl',
            size = 0.5,
          }, {
            id = 'console',
            size = 0.5,
          } },
          position = 'bottom',
          size = 10,
        },
      },
    }

    -- Register configurations for javascript. In the future, if more lenguages are needed, we should move the configs to a new file dapConfigs.lua or someting like that but since I mostly work on js right now I don't care
    local js_based_languages = { 'typescript', 'javascript', 'typescriptreact' }

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Start Chrome with "localhost"',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir',
        },
      }
    end

    -- Create nvim command to launch debug that reads launch.json
    vim.api.nvim_create_user_command('Debug', function()
      -- attempt to load any .vscode/launch.json
      if vim.fn.filereadable '.vscode/launch.json' then
        require('dap.ext.vscode').load_launchjs(nil, {
          ['pwa-node'] = js_based_languages,
          ['node'] = js_based_languages,
          ['chrome'] = js_based_languages,
          ['pwa-chrome'] = js_based_languages,
        })
      end

      dap.continue()
    end, { desc = 'Start debugging session' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Configure each lenguage here!!
    -- Javascript/Typescript
    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
      adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
    }
  end,
}
