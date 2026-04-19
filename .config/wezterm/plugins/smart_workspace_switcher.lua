local wezterm = require("wezterm")
local utils = require("utils")
local workspace_switcher =
	wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local M = {}

function M.apply(config)
	utils.add_keys(config, {
		{
			key = "s",
			mods = utils.mod,
			action = workspace_switcher.switch_workspace(),
		},
	})
end

return M
