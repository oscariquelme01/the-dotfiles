local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")
local awful = require("awful")
local icons = require("icons")

return function ()
    local blue_light = wibox.widget{
        {
            {
                widget = wibox.widget.imagebox,
                image = icons.blue_light,
            },
            widget = wibox.container.margin,
            left = dpi(12),
            right = dpi(12),
            bottom = dpi(8),
        },
        widget = wibox.container.background,
        bg = beautiful.green,
        shape = utils.rounded_rect(dpi(16)),
        forced_width = dpi(100),
    }

    -- Initially active since the redshift service should be launched in the xinit file
    blue_light.active = true

    -- Click to toggle the blue light
    blue_light:connect_signal("button::press", function ()

        if blue_light.active then
            blue_light.bg = beautiful.dark_grey
            blue_light.active = false
        else
            blue_light.bg = beautiful.green
            blue_light.active = true
        end
        awful.spawn.easy_async_with_shell("pkill -USR1 '^redshift$'")

    end)

    return blue_light
end
