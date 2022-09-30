local awful = require("awful")
local beautiful = require("beautiful")

return function ()
    local date_format = '<span font="' .. beautiful.font .. '" foreground="' .. beautiful.text .. '">%a %d %b</span>'
    local time_format = '<span font="' .. beautiful.font .. '" foreground="' .. beautiful.text .. '">%H:%M</span>'

    local clock = awful.widget.textclock(time_format .. " ".. date_format, 5)

    return clock
end
