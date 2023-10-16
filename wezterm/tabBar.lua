local wezterm = require("wezterm")
local module = {}

local pallette = require("pallette")

local mysplit = function (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function module.apply_to_config(config)
  config.window_frame = {
    font = wezterm.font("FiraCode Nerd Font"),
    font_size = 14.0,
    active_titlebar_bg = pallette.orange,
    inactive_titlebar_bg = pallette.black
  }

  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = false


  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

  -- The filled in variant of the > symbol
  local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

  -- This function returns the suggested title for a tab.
  -- It prefers the title that was set via `tab:set_title()`
  -- or `wezterm cli set-tab-title`, but falls back to the
  -- title of the active pane in that tab.
  function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
      return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab

    local splittedTitle = mysplit(tab_info.active_pane.title, '/')
    return splittedTitle[#splittedTitle]

  end

  wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
      local background = pallette.red
      local foreground = pallette.white
      local left_edge_background = pallette.red
      local left_edge_foreground = pallette.grey
      local right_edge_background = pallette.grey
      local right_edge_foreground = pallette.red

      if tab.is_active then
        background = pallette.green
        left_edge_foreground = pallette.grey
        left_edge_background = background
        right_edge_foreground = background
      end

      local is_first_tab = tab.tab_index == 0
      if is_first_tab then
        if tab.is_active then
          left_edge_foreground = pallette.red
        end
        left_edge_foreground = background
      end

      local is_last_tab = #tabs - 1 == tab.tab_index
      if is_last_tab then
        right_edge_background = pallette.black
      end

      local title = tab_title(tab)

      -- ensure that the titles fit in the available space,
      -- and that we have room for the edges.
      title = wezterm.truncate_right(title, max_width - 2)

      return {
        { Background = { Color = left_edge_background } },
        { Foreground = { Color = left_edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = ' ' .. title  .. ' ' },
        { Background = { Color = right_edge_background } },
        { Foreground = { Color = right_edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
      }
    end
  )
end

return module
