local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")
local awful = require("awful")
local icons = require("icons")

return function ()
    local bluetooth = wibox.widget{
        {
            {
                widget = wibox.widget.imagebox,
                image = icons.bluetooth,
            },
            widget = wibox.container.margin,
            left = dpi(30),
            top = dpi(8),
            right = dpi(12),
            bottom = dpi(8),
        },
        widget = wibox.container.background,
        bg = beautiful.yellow,
        shape = utils.rounded_rect(dpi(16)),
        forced_width = dpi(100),
    }

    -- Initially active since the redshift service should be launched in the xinit file
    bluetooth.active = true

    -- Click to toggle the blue light
    bluetooth:connect_signal("button::press", function ()

        if bluetooth.active then
            bluetooth.bg = beautiful.dark_grey
            bluetooth.active = false
        else
            bluetooth.bg = beautiful.yellow
            bluetooth.active = true
        end

    end)

    return bluetooth
end
