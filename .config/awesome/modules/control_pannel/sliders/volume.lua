local wibox = require("wibox")
local utils = require("utilities.utils")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local awful = require("awful")

return function ()
    local volume_slider = wibox.widget{
        forced_width = dpi(360),
        bar_shape = utils.rounded_rect(dpi(4)),
        bar_height = dpi(4),
        bar_active_color = beautiful.light_blue,
        bar_color = beautiful.grey,

        maximum = 100,
        minimum = 0,
        value = 100,

        handle_color = beautiful.light_blue,
        handle_shape = gears.shape.circle,
        handle_width = dpi(16),
        -- handle_border_width = 3,
        -- handle_border_color = beautiful.red,

        widget = wibox.widget.slider,
    }

    local volume_icon = wibox.widget{
        widget = wibox.widget.textbox,
        font = beautiful.icon_font .. "24",
        align = 'center',
        valign = 'center'
    }

    local volume_text = wibox.widget{
        widget = wibox.widget.textbox,
        font = beautiful.font_large,
        align = 'center',
        valign = 'center'
    }

    --get initial value and icon and set the widgets initial values
    local initial_icon
    local initial_value
    local cmd = "amixer get Master | tail -n 1 | awk '{print $4}' | tr -d '[%]'"
    awful.spawn.easy_async_with_shell(cmd, function (output)
        initial_value = tonumber(output)

        if initial_value == 0 then initial_icon = "ﱝ"
        else initial_icon = "墳" end


        volume_icon.markup = utils.colorize_text(initial_icon, beautiful.text)
        volume_text.markup = utils.colorize_text(output .. "%", beautiful.text)
        volume_slider.value = initial_value
    end)

    -- update widgets when the value of the slider changes
    volume_slider:connect_signal("property::value", function ()

        -- update icon
        local updated_icon

        if volume_slider.value == 0 then updated_icon = "ﱝ"
        else updated_icon = "墳" end

        volume_icon.markup = utils.colorize_text(updated_icon, beautiful.text)

        -- update text
        volume_text.markup = utils.colorize_text(tostring(volume_slider.value .. "%"), beautiful.text)

        -- update volume
        awful.spawn("amixer set Master " .. volume_slider.value .."%", false)
    end)

    -- return widget that puts everything together
    return wibox.widget {
        {
            volume_icon,
            volume_slider,
            volume_text,
            layout = wibox.layout.fixed.horizontal,
            spacing = 10
        },
        forced_height = dpi(24),
        -- forced_width = dpi(400),
        widget = wibox.widget.background,
    }

end
