local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local icons = require("icons")

return function ()
    local ram_icon = wibox.widget {
        widget = wibox.widget.imagebox,
        image = gears.color.recolor_image(icons.disk, beautiful.green),
    }

    -- return progress widget
    return wibox.widget{
    {
            ram_icon,
            widget = wibox.container.margin,
            margins = dpi(12)
        },
        forced_width = dpi(100),
        forced_height = dpi(100),
        border_width = dpi(3),
        border_color = beautiful.dark_grey,
        color = beautiful.green,
        value = 0.5,
        max_value = 1,
        min_value = 0,
        widget = wibox.container.radialprogressbar
    }
end
