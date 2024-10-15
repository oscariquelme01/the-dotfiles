local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local utils = require("utilities.utils")

local icons = require("icons")

return function ()
    -- profile image
    local profile_image = wibox.widget {
        {
            widget = wibox.widget.imagebox,
            image = icons.prof_pic,
        },
        widget = wibox.container.background,
        bg = beautiful.yellow,
        shape = gears.shape.circle,
        forced_width = dpi(100),
        forced_height = dpi(100),
        shape_border_width = dpi(2),
        shape_border_color = beautiful.dark_grey,
        shape_clip = true,
        clip_shape = true,
    }

    local user_text = wibox.widget{
        widget = wibox.widget.textbox,
        font = beautiful.font_large,
    }

    local logged_text = wibox.widget{
        widget = wibox.widget.textbox,
        font = beautiful.font,
    }

    -- Get the parsed output needed for the widgets
    awful.spawn.easy_async("who", function (output)
        local parsed_output = utils.split(output, ' ')

        -- Set username
        user_text.markup = utils.colorize_text(parsed_output[1], beautiful.text)

        -- Set active since time. If the date output is today, show the hour, else, show the date
        local today = os.date("%Y-%m-%d")
        if today == parsed_output[3] then
            -- show time
            logged_text.markup = utils.colorize_text("Active since " .. parsed_output[4], beautiful.dark_grey)
        else
            -- show date
            logged_text.markup = utils.colorize_text("Active since " .. parsed_output[3], beautiful.dark_grey)
        end
    end)


    return wibox.widget{
        {
            profile_image,
            {
                nil, -- pushes down the other two text so it looks better. See align layour docs for more info
                user_text,
                logged_text,
                layout = wibox.layout.align.vertical,
            },
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(15)
        },
        widget = wibox.container.margin,
        margins = dpi(20)
    }
end
