local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")

local blue_light_toggler = require("modules.control_pannel.togglers.blue_light")
local bluetooth_toggler = require("modules.control_pannel.togglers.bluetooth")
local wifi_toggler = require("modules.control_pannel.togglers.wifi")

return function ()
    local blue_light = blue_light_toggler()
    local bluetooth = bluetooth_toggler()
    local wifi = wifi_toggler()

    -- Layout required widgets
    return wibox.widget{
                {
                    {
                        {
                            blue_light,
                            bluetooth,
                            wifi,
                            layout = wibox.layout.fixed.horizontal,
                            spacing = dpi(44)
                        },
                        widget = wibox.container.margin,
                        right = dpi(20),
                        left = dpi(20),
                    },
                    widget = wibox.container.background,
                    bg = beautiful.deeper_black,
                    shape = utils.rounded_rect(dpi(10)),
                },
                widget = wibox.container.margin,
                left = dpi(40),
                right = dpi(40),
                top = dpi(6),
                bottom = dpi(6),
                forced_height = dpi(100)
    }
end
