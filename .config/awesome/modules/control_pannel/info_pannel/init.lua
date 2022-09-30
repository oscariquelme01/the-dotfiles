local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")

local ram = require("modules.control_pannel.info_pannel.ram")
local temperature = require("modules.control_pannel.info_pannel.temperature")
local cpu = require("modules.control_pannel.info_pannel.cpu")
local disk = require("modules.control_pannel.info_pannel.disks")

return function ()

    local ram_widget = ram()
    local temperature_widget = temperature()
    local cpu_widget = cpu()
    local disk_widget = disk()

    return wibox.widget{
    {
        {
                ram_widget,
                cpu_widget,
                disk_widget,
                temperature_widget,
                spacing = dpi(16),
                layout = wibox.layout.fixed.horizontal
            },
            widget = wibox.container.margin,
            margins = dpi(14)
        },
        widget = wibox.container.background,
        bg = beautiful.black,
        shape = utils.rounded_rect(dpi(12))
    }

end
