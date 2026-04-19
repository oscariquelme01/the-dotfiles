-- Vesper theme for WezTerm
-- Source: https://github.com/raunofreiberg/vesper

local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	-- Font
	config.font = wezterm.font_with_fallback({
		{
			family = "GeistMono Nerd Font",
			weight = "Regular",
			style = "Normal",
		},
	})
	config.font_size = 14.0

	-- Change inactive pane brightness
	config.inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.5,
	}

	-- Explicit font variants (bold, italic, bold italic)
	config.font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "GeistMono Nerd Font",
				weight = "Bold",
				style = "Normal",
			}),
		},
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "GeistMono Nerd Font",
				weight = "Regular",
				style = "Italic",
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "GeistMono Nerd Font",
				weight = "Bold",
				style = "Italic",
			}),
		},
	}

	-- Colors
	config.color_scheme = "Vesper"

	-- Window
	-- Closest equivalent to Alacritty's "Buttonless" (macOS): hide title bar but
	-- keep window resizable. On other platforms this just removes decorations.
	config.window_decorations = "RESIZE"
end

return M
