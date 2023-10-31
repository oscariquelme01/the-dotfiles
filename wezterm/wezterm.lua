local config = {}
local wezterm = require("wezterm")

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14.0
config.adjust_window_size_when_changing_font_size = false
config.tiling_desktop_environments = {
  'X11 awesome'
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.colors = require("./theme")

local tabbar = require("tabBar")
tabbar.apply_to_config(config)
local keys = require("keybinds")
keys.apply_to_config(config)
local workspaces = require("workspaces")


wezterm.on('gui-startup', function()
  workspaces.loadWorkspaces()
end)

wezterm.on('save-workspaces', function ()
  local activeWorkspace = wezterm.mux.get_active_workspace()
  print(wezterm.mux.all_windows())
  for _, window in ipairs(wezterm.mux.all_windows()) do
    if window:get_workspace() == activeWorkspace then
      window:gui_window():toast_notification('(Workspaces)', 'Saving workspaces...', nil, 5000)
    end
  end
  workspaces.saveWorkspaces()
end)

return config
