local module = {}
local wezterm = require('wezterm')
local mux = wezterm.mux

local home = os.getenv('HOME') .. '/'

local customWorkspaces = {
  dotfiles = {
    workspace = 'dotfiles',
    cwd = home .. '.config',
    tabs = {
      {
        name = 'nvim',
        cwd = 'nvim',
      },
      {
        name = 'awesome',
        cwd = 'awesome',
      },
      {
        name = 'wezterm',
        cwd = 'wezterm',
      }
    }
  },
  rfrancoFrontend = {
    workspace = 'rfrancoFrontend',
    cwd = home .. 'rfranco',
    tabs = {
      {
        name = 'code',
        cwd = 'treasureship_front'
      },
      {
        name = 'terms',
        cwd = 'treasureship_front'
      },
      {
        name = 'fileManager',
        cwd = '.',
        command = 'ranger .\n'
      }
    }
  },
  infonis = {
    workspace = 'infonis',
    cwd = home .. 'infonis',
    tabs = {
      {
        name = 'code',
        cwd = 'allergan'
      },
      {
        name = 'terms',
        cwd = 'allergan'
      },
      {
        name = 'fileManager',
        cwd = '.',
        command = 'ranger .\n'
      }
    }
  },
  default = {
    workspace = 'default',
    cwd = home,
    tabs = {
      {
        name = 'default',
        cwd = '.'
      }
    }
  }
}

function module.apply_to_config()
  wezterm.on('gui-startup', function (_)
    -- spawn as many tabs as needed for each workspace
    for _, v in pairs(customWorkspaces) do
      local firstTab, _, window = mux.spawn_window {
        workspace = v.workspace,
        cwd = v.cwd,
      }

      local tabs = window:tabs()

      local flag = false
      local i = 1

      while flag == false do
        if i == 1 then
          firstTab:set_title(v.tabs[i].name)
          firstTab:active_pane():send_text('cd ' .. v.tabs[i].cwd .. ' && clear\n')

          if v.tabs[i].command ~= nil then
            firstTab:active_pane():send_text(v.tabs[i].command)
          end
        end

        if #tabs >= #v.tabs then
          flag = true
        else
          i = i + 1
          local tab, _, _ = window:spawn_tab {}
          tabs = window:tabs()

          tab:set_title(v.tabs[i].name)
          tab:active_pane():send_text('cd ' .. v.tabs[i].cwd .. '&& clear\n')

          if v.tabs[i].command ~= nil then
            tab:active_pane():send_text(v.tabs[i].command)
          end
        end
      end

      firstTab:activate()
    end

    mux.set_active_workspace 'default'
  end)
end

return module
