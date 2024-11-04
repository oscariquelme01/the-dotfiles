local awful = require("awful")
local wibox = require("wibox")
local icons = require("assets.icons")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = {
		awful.button({}, 1, function()
			c:activate({ context = "titlebar", action = "mouse_move" })
		end),
		awful.button({}, 3, function()
			c:activate({ context = "titlebar", action = "mouse_resize" })
		end),
	}

	local titlebar = awful.titlebar(c, {
		size = 30,
		bg = beautiful.black,
	})

	titlebar.widget = {
		-- TODO: make this better, since this is the first thing I am developing here, I don't know a better way of getting the layout right
		-- This is a hacky way to leverage the wibox.layout.align default layout. However, when I get better at awesomeWM lib, I might come back to this
		wibox.widget.textbox(""),
		{ -- Center
			{ -- Title
				font = beautiful.font,
				halign = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			{ -- Outer margin widget
				{ -- Background widget
					{ -- Inner margin widget
						widget = awful.titlebar.widget.closebutton(c),
					},
					margins = dpi(6),
					widget = wibox.container.margin,
				},
				bg = beautiful.one_bg2,
				shape = gears.shape.rounded_rect,
				widget = wibox.container.background,
			},
			margins = dpi(8),
			widget = wibox.container.margin,
		},
		layout = wibox.layout.align.horizontal,
	}
end)
