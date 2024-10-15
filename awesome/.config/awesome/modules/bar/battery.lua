local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local watch = require("awful.widget.watch")

local utils = require("utilities.utils")

return function ()

-- inspired by https://github.com/saimoomedits/dotfiles/ battery widget

    local battery_progress = wibox.widget {
    	color				= beautiful.green,
    	background_color	= beautiful.dark_grey,
        forced_width        = dpi(27),
        border_width        = dpi(0.5),
        border_color        = beautiful.dark_grey,
        paddings            = dpi(2),
        bar_shape           = utils.rounded_rect(dpi(2)),
    	shape				= utils.rounded_rect(dpi(4)),
        value               = 70,
    	max_value 			= 100,
        widget              = wibox.widget.progressbar,
    }

    -- icon that will be displayed when the battery is charging
    local charging_icon = wibox.widget {
        markup = '<span foreground="'.. beautiful.light_white ..'"font="' .. beautiful.font .. '"></span>',
        align  = 'center', valign = 'center',
        widget = wibox.widget.textbox,
        visible = false
    }

    local battery = wibox.widget {
        {
            {
                {
                    wibox.widget.base.make_widget(),
                    widget = wibox.container.background,
                    bg = beautiful.dark_grey,
                    shape = utils.rounded_rect(dpi(2)),
                    forced_width = dpi(2),
                    forced_height = dpi(4)
                },
                layout = wibox.container.margin,
                right = dpi(4),
                left = dpi(4),
            },
            {
                {
                        battery_progress,
                        direction = "east",
                        widget = wibox.container.rotate()
                },
                {
                        charging_icon,
                        widget = wibox.container.background,
                        shape = utils.rounded_rect(2),
                        forced_width = dpi(2),
                        forced_height = dpi(4)
                },
                layout = wibox.layout.stack
            },
            layout = wibox.layout.fixed.vertical,
        },
        layout = wibox.container.margin,
        left = dpi(8),
        right = dpi(8)
    }

    -- update battery widget
    awesome.connect_signal("signal::battery", function(value, _)
        battery_progress.value = value
    end)


    -- Update battery widget. 5 is the timeout
    watch("acpi", 5,
    function(widget, stdout)
        local charge

        -- for each line the command outputted
        for s in stdout:gmatch("[^\r\n]+") do
            local status, charge_str, _ = string.match(s, '.+: ([%a%s]+), (%d?%d?%d)%%,?(.*)')

            charge = tonumber(charge_str)
            battery_progress.value = charge

            -- show/hide charging icon
            if status == 'Charging' and charging_icon.visible ~= true then
                charging_icon.visible = true
            end
            if status == 'Discharging' and charging_icon.visible ~= false then
                charging_icon.visible = false
            end

            -- change color based on battery percentage
            if charge < 10 then
                battery_progress.color = beautiful.red
            elseif charge < 30 then
                battery_progress.color = beautiful.yellow
            elseif charge < 90 then
                battery_progress.color = beautiful.green
            else
                battery_progress.color = beautiful.light_blue
            end
        end

        battery.charge = charge
    end,
    battery)

    return battery
end
