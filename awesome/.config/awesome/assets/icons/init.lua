--- Icons directory
local gfs = require("gears.filesystem")
local dir = gfs.get_configuration_dir() .. "assets/icons/"

return {
	--- layouts
	closeClient = dir .. "closeClient.svg",
}
