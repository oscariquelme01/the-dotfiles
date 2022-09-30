local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utilities.utils")
local dpi = beautiful.xresources.apply_dpi

-- sliders
local volume_slider = require("modules.control_pannel.sliders.volume")
local mic_slider = require("modules.control_pannel.sliders.mic")

return function()
    -- instantiate sliders
    local volume = volume_slider()
    local mic = mic_slider()

    return wibox.widget{
                {
                    {
                        {
                            volume,
                            mic,
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(40)
                        },
                        widget = wibox.container.margin,
                        margins = dpi(20),
                    },
                    widget = wibox.container.background,
                    bg = beautiful.black,
                    shape = utils.rounded_rect(dpi(10)),
                },
                widget = wibox.container.margin,
                margins = dpi(6),
    }
end
