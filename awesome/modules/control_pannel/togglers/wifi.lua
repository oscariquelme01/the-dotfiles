local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")
local awful = require("awful")
local icons = require("icons")

return function ()
    local wifi = wibox.widget{
        {
            {
                widget = wibox.widget.imagebox,
                image = icons.wifi,
            },
            widget = wibox.container.margin,
            left = dpi(14),
            top = dpi(8),
            right = dpi(14),
            bottom = dpi(8),
        },
        widget = wibox.container.background,
        bg = beautiful.blue,
        shape = utils.rounded_rect(dpi(16)),
        forced_width = dpi(100),
    }

    -- Initially active since the redshift service should be launched in the xinit file
    wifi.active = true

    -- Click to toggle the blue light
    wifi:connect_signal("button::press", function ()

        if wifi.active then
            wifi.bg = beautiful.dark_grey
            wifi.active = false
        else
            wifi.bg = beautiful.blue
            wifi.active = true
        end

    end)

    return wifi
end
