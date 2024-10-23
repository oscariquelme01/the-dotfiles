local theme = {}

theme.font = "Roboto Medium 10"
theme.icon_font = "Material Icon Round "
theme.icon_theme = "custom-papyrus"

--- Special
theme.white = "#edeff0"
theme.darker_black = "#060809"
theme.black = "#0c0e0f"
theme.lighter_black = "#121415"
theme.one_bg = "#161819"
theme.one_bg2 = "#1f2122"
theme.one_bg3 = "#27292a"
theme.grey = "#343637"
theme.grey_fg = "#3e4041"
theme.grey_fg2 = "#484a4b"
theme.light_grey = "#505253"

-- Black
theme.color0 = "#1e2129"
theme.color8 = "#27292a"

-- Red
theme.color1 = "#e8646a"
theme.color9 = "#dc6b74"

-- Green
theme.color2 = "#a6d189"
theme.color10 = "#7fc7a2"

-- Yellow
theme.color3 = "#ebcb6b"
theme.color11 = "#e5c890"

-- Blue
theme.color4 = "#61afef"
theme.color12 = "#4489ce"

-- Magenta
theme.color5 = "#ea76cb"
theme.color13 = "#f488eF"

-- Cyan
theme.color6 = "#6aa6a5"
theme.color14 = "#81c8be"

-- White
theme.color7 = "#e4e6e7"
theme.color15 = "#f2f4f5"

theme.accent = theme.color4

--- Background Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.black
theme.bg_urgent = theme.black
theme.bg_minimize = theme.black

--- Foreground Colors
theme.fg_normal = theme.white
theme.fg_focus = theme.accent
theme.fg_urgent = theme.color1
theme.fg_minimize = theme.color0

theme.border_width = 1
theme.border_color = theme.color8

-- Window switcher
theme.window_switcher_widget_bg = theme.lighter_black           -- The bg color of the widget
theme.window_switcher_widget_border_width = 1                   -- The border width of the widget
theme.window_switcher_widget_border_radius = 0                  -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.border_color  -- The border color of the widget
theme.window_switcher_clients_spacing = 20                      -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5        -- The space between client icon and text
theme.window_switcher_client_width = 150                        -- The width of one client widget
theme.window_switcher_client_height = 250                       -- The height of one client widget
theme.window_switcher_client_margins = 10                       -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10                    -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = true                                    -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10                         -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"                    -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200                   -- The width of one title
theme.window_switcher_name_font = theme.font                     -- The font of all titles
theme.window_switcher_name_normal_color = theme.white           -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.color1              -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center"                    -- How to vertically align the one icon
theme.window_switcher_icon_width = 40                           -- The width of one icon

return theme
