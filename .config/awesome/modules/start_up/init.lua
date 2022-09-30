local awful = require("awful")

-- autostart matters
local is_laptop

if os.getenv("IS_LAPTOP") then is_laptop = true else is_laptop = false end

-- laptop specific actions
if is_laptop then
    awful.spawn.with_shell("feh --bg-scale ~/.config/bg/pacman-bg.png")

-- pc specific actions
else
    awful.spawn.with_shell("feh --bg-scale ~/.config/bg/dark-pink-city-5k.png")
    awful.spawn.with_shell("xrandr --output HDMI-0 --right-of DP-0")
    awful.spawn.with_shell('xmodmap -e "keycode 51 = less greater less greater"')
    awful.spawn.with_shell('xmodmap -e "keycode 21 = backslash questiondown exclamdown questiondown dead_tilde asciitilde dead_tilde"')
end

-- TODO: create script to determine whether the slider.lua file needs to be updated for the sliders to work
