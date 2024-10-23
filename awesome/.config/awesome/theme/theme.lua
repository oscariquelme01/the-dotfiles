local theme = {}

theme.font = "Roboto Medium 10"
theme.icon_font = "Material Icon Round "

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

return theme

