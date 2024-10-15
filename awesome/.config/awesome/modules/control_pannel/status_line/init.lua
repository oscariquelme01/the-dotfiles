local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- require status bar widgets
local battery_widget = require("modules.control_pannel.status_line.battery")
local date_widget = require("modules.control_pannel.status_line.date")
local toggle_info_widget = require("modules.control_pannel.status_line.toggle_info")

return function (action)
    local is_laptop

    local  battery
    if is_laptop then
        battery = battery_widget()
    else
        battery = wibox.widget{
            wibox.widget.base.make_widget(),
            widget = wibox.container.background,
            bg = beautiful.deep_black,
            forced_width = dpi(50)
        }
    end
    local date = date_widget()
    local toggle_info = toggle_info_widget(action)

    return wibox.widget{
        battery,
        {
            toggle_info,
            widget = wibox.container.margin,
            top = dpi(8),
            bottom = dpi(8),
            left = dpi(130),
            right = dpi(130)
        },
        date,
        layout = wibox.layout.align.horizontal,
        widget = wibox.container.background,
        bg = beautiful.deep_black,
        forced_height = dpi(35),
    }
end
