local bling = require("lib.bling")
local gears = require("gears")
local awful = require("awful")

local wallpaper_dir = gears.filesystem.get_configuration_dir() .. "assets/wallpaper/"

awful.screen.connect_for_each_screen(function(s)
	local screen_width = s.geometry.width
	local screen_height = s.geometry.height

	local screen_orientation = screen_width > screen_height and "horizontal" or "vertical"

	bling.module.wallpaper.setup({
		screen = s,
		wallpaper = wallpaper_dir .. screen_orientation .. "/pacman.png", -- TODO: improve this and don't hard code it
		position = "fit" -- center wallpaper and scale it to fix screen size
	})
end)
