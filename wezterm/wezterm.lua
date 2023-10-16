local config = {}
local wezterm = require("wezterm")

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14.0

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
workspaces.apply_to_config()

return config
