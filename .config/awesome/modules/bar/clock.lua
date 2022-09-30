local beautiful = require("beautiful")
local awful = require("awful")

return function()

    -- local date_format = '<span font="' .. beautiful.font .. '" foreground="' .. beautiful.yellow .. '">%a %b %d</span>'
    local time_format = '<span font="' .. beautiful.font_large .. '" foreground="' .. beautiful.white .. '">%H\n%M</span>'

    local clock = awful.widget.textclock(time_format, 5)

    return clock

end
