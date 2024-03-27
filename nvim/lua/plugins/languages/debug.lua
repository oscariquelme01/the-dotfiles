-- Global function to run dap with args and to select configs
function _G.dapRunConfigWithArgs()
  local dap = require 'dap'
  local ft = vim.bo.filetype
  if ft == '' then
    print 'Filetype option is required to determine which dap configs are available'
    return
  end
  local configs = dap.configurations[ft]
  if configs == nil then
    print('Filetype "' .. ft .. '" has no dap configs')
    return
  end
  local mConfig = nil
  vim.ui.select(configs, {
    prompt = 'Select config to run: ',
    format_item = function(config)
      return config.name
    end,
  }, function(config)
    mConfig = config
  end)

  -- redraw to make ui selector disappear
  vim.api.nvim_command 'redraw'

  if mConfig == nil then
    return
  end
  vim.ui.input({
    prompt = mConfig.name .. ' - with args: ',
  }, function(input)
    if input == nil then
      return
    end
    local args = vim.split(input, ' ', true)
    mConfig.args = args
    dap.run(mConfig)
  end)
end

vim.api.nvim_create_user_command('Debug', function ()
  -- attempt to load any .vscode/launch.json
  local dap = require('dap')
  require('dap.ext.vscode').load_launchjs()

  dap.continue()
end, { desc = 'Start debugging session' })

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python'
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,
      handlers = {},

      ensure_installed = {
        'delve',
      },
    }
    local keymap = vim.keymap.set

    -- Basic debugging keymaps, feel free to change to your liking!
    keymap('n', '<leader>dn', dap.continue, { desc = 'Debug: Start/Continue' })
    keymap('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
    keymap('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
    keymap('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    keymap('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    keymap('n', '<leader>dt', dapui.toggle, { desc = 'Debug: See last session result.' })
    keymap('n', '<leader>df', ':DapTerminate<CR>', { desc = 'Debug: See last session result.', silent = true })

    -- Dap UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
  end,
}
