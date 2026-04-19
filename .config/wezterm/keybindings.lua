local wezterm = require("wezterm")
local utils = require("utils")

local mod = utils.mod

local M = {}

function M.apply(config)
	config.keys = {
		-- Split vertically
		{
			key = "v",
			mods = mod  .. "|ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- Split horizontally (I know, names are backward)
		{
			key = "x",
			mods = mod .. "|ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = mod .. "|ALT",
			action = wezterm.action.PromptInputLine({
				description = "Enter name for new workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(wezterm.action.SwitchToWorkspace({ name = line }), pane)
					end
				end),
			}),
		},
		{
			key = "t",
			mods = mod,
			action = wezterm.action.SpawnTab 'CurrentPaneDomain',
		},
		{
			key = "t",
			mods = mod .. "|ALT",
			action = wezterm.action.PromptInputLine({
				description = "Enter new tab name",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		-- Paste from clipboard
		{
			key = "p",
			mods = mod,
			action = wezterm.action.PasteFrom("Clipboard"),
		},
		-- Enter copy mode
		{
			key = "x",
			mods = mod,
			action = wezterm.action.ActivateCopyMode,
		},
		-- Redo: forward as Ctrl+r to Neovim
		{
			key = "r",
			mods = mod,
			action = wezterm.action.SendKey({ key = "r", mods = "CTRL" }),
		},
	}
end

return M
