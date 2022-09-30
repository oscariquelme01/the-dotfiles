
--- Icons directory
local gfs = require("gears.filesystem")
local dir = gfs.get_configuration_dir() .. "icons/"

return {
    ghost = dir .. "ghost.svg",
    scared_ghost = dir .. "scared-ghost.svg",
    circle = dir .. "circle.svg",
    rocket = dir .. "rocket.png",
    blue_light = dir .. "night-light.png",
    bluetooth = dir .. "bluetooth.png",
    wifi = dir .. "wifi.png",
    prof_pic = dir .. "madao.png",
    ram = dir .. "ram.svg",
    temperature = dir .. "temperature.svg",
    cpu = dir .. "cpu.svg",
    disk = dir .. "disk.svg"
}
