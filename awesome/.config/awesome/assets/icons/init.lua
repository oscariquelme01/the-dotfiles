--- Icons directory
local gfs = require("gears.filesystem")
local dir = gfs.get_configuration_dir() .. "assets/icons/"

return {
	--- layouts
	closeClient = dir .. "close_client.svg",
	closeClientHover = dir .. "close_client_hover.svg",
	closeClientPress = dir .. "close_client_press.svg",
}
