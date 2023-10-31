local wezterm = require("wezterm")
local module = {}

local pallette = require("pallette")

function module.apply_to_config(config)
  config.keys = {
    { key = 'Space', mods = 'CTRL', action = wezterm.action.ActivateCopyMode },
    { key = 'n',     mods = 'ALT',  action = wezterm.action.SpawnTab 'DefaultDomain' },
    { key = 'd',     mods = 'ALT',  action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = 'x',     mods = 'ALT',  action = wezterm.action.SplitVertical {} },
    { key = 'v',     mods = 'ALT',  action = wezterm.action.SplitHorizontal {} },
    { key = 'i',     mods = 'ALT',  action = wezterm.action.SwitchToWorkspace },
    { key = 's',     mods = 'ALT',  action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES'}},
    { key = 'p',     mods = 'ALT',  action = wezterm.action.EmitEvent 'save-workspaces' },
    { key = 'w',     mods = 'ALT',  action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' }},
        { Foreground = { Color = pallette.white }},
        { Text = 'Enter name for new workspace'}
      },
      action = wezterm.action_callback(function (window, pane, line)
        if line then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = line
            },
            pane
          )
        end
      end)
    }},
    { key = 'r',     mods = 'ALT',  action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' }},
        { Foreground = { Color = pallette.white }},
        { Text = 'Rename current workspace'}
      },
      action = wezterm.action_callback(function (window, pane, line)
        if line then
          window:perform_action(
            wezterm.mux.rename_workspace(
              wezterm.mux.get_active_workspace(),
              line
            ),
            pane
          )
        end
      end)
    }},
    { key = 't',     mods = 'ALT',  action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' }},
        { Foreground = { Color = pallette.white }},
        { Text = 'Rename current tab'}
      },
      action = wezterm.action_callback(function (_, pane, line)
        if line then
          pane:tab():set_title(line)
        end
      end)
    }},
  }

  -- tab navigation
  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'ALT',
      action = wezterm.action.ActivateTab(i - 1),
    })
  end

  -- pane navigation
  local navigation_keybinds = require("navigation")

  for _, keybind in pairs(navigation_keybinds) do
    table.insert(config.keys, keybind)
  end
end

return module
