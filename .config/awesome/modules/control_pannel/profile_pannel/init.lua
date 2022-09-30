local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local profile = require("modules.control_pannel.profile_pannel.profile")

return function()

    -- widgets
    local profile_widget = profile()

     -- main widget to return
     local container = wibox.widget{
         profile_widget,
         widget = wibox.container.background,
         layout = wibox.layout.align.horizontal,
         expand = true,
         bg = beautiful.deep_black
     }


    return container

end
