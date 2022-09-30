 local wibox = require("wibox")
 local awful = require("awful")
 local beautiful = require("beautiful")
 local dpi = beautiful.xresources.apply_dpi
 local utils = require("utilities.utils")

 local taglist = require("modules.bar.taglist")
 local clock = require("modules.bar.clock")
 local launcher = require("modules.bar.launcher")
 local battery = require("modules.bar.battery")
 local menu = require("modules.bar.menu")

 local is_laptop = os.getenv("IS_LAPTOP")
 if os.getenv("IS_LAPTOP") then is_laptop = true else is_laptop = false end


 awful.screen.connect_for_each_screen(
     function(s)
         -- instantiate widgets
         s.taglist = taglist(s)
         s.clock = clock()
         if is_laptop then s.battery = battery() else s.battery = nil end
         s.launcher = launcher()
         s.menu = menu(function() s.control_pannel.toggle() end)

         -- wibar
         s.wibar = awful.wibar({position = "left", screen = s, stretch = true})

         s.wibar:setup {
             { -- Left widgets
                s.launcher,
                top = dpi(8),
                left = dpi(6),
                right = dpi(6),
                layout = wibox.layout.margin,
             },
             { -- Middle widgets
                s.taglist,
                widget = wibox.container.margin
             },
             { -- Right widgets
                {
                     s.menu,
                     right = dpi(2),
                     left = dpi(2),
                     layout = wibox.container.margin
                 },
                {
                     s.battery,
                     left = dpi(4),
                     right = dpi(4),
                     layout = wibox.container.margin
                 },
                {
                    s.clock,
                    left = dpi(8),
                    layout = wibox.container.margin
                 },
                 layout = wibox.layout.fixed.vertical,
                 spacing = dpi(2)
             },
             layout = wibox.layout.align.vertical,
             expand = "none",
         }
     end)

