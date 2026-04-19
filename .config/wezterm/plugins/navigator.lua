local wezterm = require("wezterm")
local act = wezterm.action

local utils = require("utils")

local function isViProcess(pane)
	-- get_foreground_process_name On Linux, macOS and Windows,
	-- the process can be queried to determine this path. Other operating systems
	-- (notably, FreeBSD and other unix systems) are not currently supported
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
			-- This should match the keybinds you set in Neovim.
			act.SendKey({ key = vim_direction, mods = "CTRL" }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

local M = {}
function M.apply(config)
	utils.add_keys(config, {
		{ key = "h", mods = utils.mod, action = act.EmitEvent("ActivatePaneDirection-left") },
		{ key = "j", mods = utils.mod, action = act.EmitEvent("ActivatePaneDirection-down") },
		{ key = "k", mods = utils.mod, action = act.EmitEvent("ActivatePaneDirection-up") },
		{ key = "l", mods = utils.mod, action = act.EmitEvent("ActivatePaneDirection-right") },
	})
end

return M
