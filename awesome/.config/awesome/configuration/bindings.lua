local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local naughty = require("naughty")

require("awful.hotkeys_popup.keys")
require("awful.autofocus")

mod = "Mod4"
alt = "Mod1"
ctrl = "Control"
shift = "Shift"

local globalkeys = {
	-- show available keybindings
	awful.key({ modkey }, "z", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- go back to previous tag
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	-- switch between keyboard layouts
	awful.key({ modkey }, "c", function()
		awful.spawn.easy_async_with_shell("setxkbmap -query | grep layout | awk '{print $2}'", function(layout)
			layout = string.gsub(layout, "\n", "")
			if tostring(layout) == "us" then
				awful.spawn.with_shell("setxkbmap es")
				naughty.notify({ text = "us => es" })
			else
				awful.spawn.with_shell("setxkbmap us")
				naughty.notify({ text = "es => us" })
			end
		end)
	end, { description = "go back", group = "tag" }),

	-- focus navigation between clients
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	-- Open terminal
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),

	-- Restart awesome
	awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	-- Quit awesome
	awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),
	-- Take screenshot
	awful.key({ modkey }, "p", function()
		awful.util.spawn("flameshot gui")
	end, { description = "take screenshot", group = "screen" }),

	-- Resizing clients
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	-- modify number of master rows
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

	-- modify number of slave columns
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	-- switching between layouts
	awful.key({ modkey, "Control" }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift", "Control" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	-- Run rofi
	awful.key({ modkey }, "r", function()
		awful.spawn("rofi -show run", false)
	end, { description = "show the menubar", group = "launcher" }),

	-- switch between screens
	awful.key({ modkey }, "s", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),

	-- increase brightness
	awful.key({ modkey }, ".", function()
		awful.spawn.with_shell("light -A 2")
	end, { description = "increase brightness", group = "screen" }),

	-- decrease brightness
	awful.key({ modkey }, ",", function()
		awful.spawn.with_shell("light -U 2")
	end, { description = "decrease brightness", group = "screen" }),

	-- toggle control pannel
	awful.key({ modkey }, "m", function()
		local screen = awful.screen.focused()
		screen.menu.toggle()
	end, { description = "toggle control pannel", group = "screen" })
}

awful.keyboard.append_global_keybindings({
	awful.key({ mod, alt }, "Left", awful.tag.viewprev, { description = "view previous", group = "tags" }),
	awful.key({ mod, alt }, "Right", awful.tag.viewnext, { description = "view next", group = "tags" }),
	awful.key({
		modifiers = { mod },
		keygroup = "numrow",
		description = "only view tag",
		group = "tags",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { mod, ctrl },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tags",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),
	awful.key({
		modifiers = { mod, shift },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tags",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
})

-- client keybinds. This will be used in rc.lua when aplying the rule for all clients
local clientkeys = gears.table.join(
	-- Toggle full screen
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	-- kill window
	awful.key({ modkey, "Shift" }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	-- toggle floating
	awful.key({ modkey }, "space", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),

	-- swap position with next/previous client
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with next client by index reverse", group = "client" }),

	-- toggle keep on top
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),

	--minimize/maximize
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "x", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	-- Move client to screen
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),

	-- move floating clients around
	awful.key({ modkey }, "Left", function(c)
		c.x = c.x - 30
	end, { description = "move floating client left", group = "client" }),
	awful.key({ modkey }, "Right", function(c)
		c.x = c.x + 30
	end, { description = "move floating client right", group = "client" }),
	awful.key({ modkey }, "Up", function(c)
		c.y = c.y - 30
	end, { description = "move floating client top", group = "client" }),
	awful.key({ modkey }, "Down", function(c)
		c.y = c.y + 30
	end, { description = "move floating client down", group = "client" }),

	-- resize floating clients
	awful.key({ modkey, "Control" }, "Left", function(c)
		c.width = c.width - 30
	end, { description = "move floating client left", group = "client" }),
	awful.key({ modkey, "Control" }, "Right", function(c)
		c.width = c.width + 30
	end, { description = "move floating client right", group = "client" }),
	awful.key({ modkey, "Control" }, "Up", function(c)
		c.height = c.height - 30
	end, { description = "move floating client top", group = "client" }),
	awful.key({ modkey, "Control" }, "Down", function(c)
		c.height = c.height + 30
	end, { description = "move floating client down", group = "client" })
)

-- client buttons. This will be used in rc.lua when aplying the rule for all clients
-- clientbuttons = gears.table.join(
--     awful.button({ }, 1, function (c)
--         c:emit_signal("request::activate", "mouse_click", {raise = true})
--     end),
--     awful.button({ modkey }, 1, function (c)
--         c:emit_signal("request::activate", "mouse_click", {raise = true})
--         awful.mouse.client.move(c)
--     end),
--     awful.button({ modkey }, 3, function (c)
--         c:emit_signal("request::activate", "mouse_click", {raise = true})
--         awful.mouse.client.resize(c)
--     end)
-- )

awful.keyboard.append_global_keybindings(globalkeys)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings(clientkeys)
end)
