 local wibox = require("wibox")
 local awful = require("awful")
 local gears = require("gears")
 local beautiful = require("beautiful")
 local dpi = beautiful.xresources.apply_dpi
 local utils = require("utilities.utils")

 local taglist = require("modules.bar.taglist")
 local timer = require("modules.bar.timer")
 local clock = require("modules.bar.clock")
 local launcher = require("modules.bar.launcher")
 local battery = require("modules.bar.battery")
 local menu = require("modules.bar.menu")

 local is_laptop = os.getenv("IS_LAPTOP")
 if os.getenv("IS_LAPTOP") then is_laptop = true else is_laptop = false end

 awful.screen.connect_for_each_screen(
     function(s)
         local geometry = s.geometry
         local orientation
         if geometry.width > geometry.height then orientation = 'horizontal' else orientation = 'vertical' end

         -- instantiate widgets
         s.taglist = taglist(s, orientation)
         s.clock = clock()
         s.timer = timer()
         if is_laptop then s.battery = battery() else s.battery = nil end
         s.launcher = launcher()
         s.menu = menu(function() s.control_pannel.toggle() end)

         local position
         if orientation == 'vertical' then position = 'top' else position = 'left' end
         -- wibar
         s.wibar = awful.wibar({position = position, screen = s, stretch = true})

         local alignLayout
         local fixedLayout
         -- counter intuitive but if the screen is horizontal, the bar is vertical
         if orientation == 'horizontal' then alignLayout = wibox.layout.align.vertical else alignLayout = wibox.layout.align.horizontal end
         if orientation == 'horizontal' then fixedLayout = wibox.layout.fixed.vertical else fixedLayout = wibox.layout.fixed.horizontal end

         local rightWidgets
         -- if the orientation ir horizontal, include right widgets, else, don't
         if orientation == 'horizontal' then
             rightWidgets = { -- Right widgets
                {
                     s.timer,
                     top = dpi(8),
                     left = dpi(4),
                     layout = wibox.layout.margin
                 },
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
                 layout = fixedLayout,
                 spacing = dpi(2)
             }
         else
             rightWidgets = {
                 layout = fixedLayout,
                 spacing = dpi(2)
             }
         end

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
             rightWidgets,
             layout = alignLayout,
             expand = "none",
         }
     end)
