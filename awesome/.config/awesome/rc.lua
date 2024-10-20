pcall(require, "luarocks.loader")

local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

modkey = "Mod4"
terminal = "alacritty"

-- INIT THEME
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local bling = require("lib.bling")

require("modules.binds.bindings")

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

-- TODO: move this
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
