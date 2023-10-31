pcall(require, "luarocks.loader")

local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

modkey = "Mod4"
terminal = "alacritty"

-- local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
-- beautiful.init(theme_dir .. "theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local bling = require("lib.bling")

require("modules.start_up")
require("modules.bar")
require("modules.binds.bindings")
require("modules.alt_tab")


if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
        title = "Error occured",
        text = awesome.startup_errors })
end


-- Order in which the different layouts will be switched
awful.layout.layouts = {
    bling.layout.equalarea,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
}

-- load globalkeys from bindings.lua
root.keys(globalkeys)

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
  end)
)

-- Control variables to track whether programs have been launched before or not
local firefox_started = false
local wezterm_started = false
local obsidian_started = false
local discord_started = 2
local teams_started = 2

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
                }
    },

    { rule = { class = "org.wezfurlong.wezterm"},
    callback = function (c)
            if not wezterm_started then
                local s = awful.screen.focused()
                c:move_to_screen(s)
                c:tags({ s.tags[1] })

                wezterm_started = true
            end
        end },

    { rule = { class = "firefox"},
    callback = function (c)
            if not firefox_started then
                local s = awful.screen.focused()
                c:move_to_screen(s)
                c:tags({ s.tags[2] })

                firefox_started = true
            end
        end },

    { rule = { class = "obsidian"},
    callback = function (c)
            if not obsidian_started then
                local s = awful.screen.focused()
                c:move_to_screen(s)
                c:tags({ s.tags[3] })

                obsidian_started = true
            end
        end },

    { rule = { class = "Microsoft Teams - Preview"},
    callback = function (c)
            if teams_started ~= 0 then
                local s = awful.screen.focused()
                c:move_to_screen(s)
                c:tags({ s.tags[4]})

                teams_started = teams_started - 1
            end
        end },

    { rule = { class = "discord"},
    callback = function (c)
            if discord_started ~= 0 then
                local s = awful.screen.focused()
                c:move_to_screen(s)
                c:tags({ s.tags[5] })

                discord_started = discord_started - 1
            end
        end },

}
