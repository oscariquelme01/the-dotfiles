local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")
local battery = require("modules.bar.battery")
local gears = require("gears")

return function ()

    -- Using the same battery widget I used on the bar, except it will be rotated and have a text value displayed
    -- I don't know how inneficient this is tho
    local battery_widget = battery()
    local battery_text = wibox.widget{
        widget = wibox.widget.textbox,
        font = beautiful.font,
        markup = '99%'
    }

    -- timer to update the text (note that the first 5 seconds after awesome starts the value will be wrong 
    gears.timer.start_new(5, function ()
        battery_text.markup = utils.colorize_text(tostring(battery_widget.charge) .. "%", beautiful.text)
        return true
    end)

    return wibox.widget{
        {
            battery_widget,
            widget = wibox.container.rotate,
            direction = 'west'
        },
        battery_text,
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal
    }
end
