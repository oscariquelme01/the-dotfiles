local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Theme
require("theme").apply(config)

-- Key bindings
require("keybindings").apply(config)

-- Plugins
require("plugins.bar").apply(config)
require("plugins.resurrect").apply(config)
require("plugins.smart_workspace_switcher").apply(config)
require("plugins.navigator").apply(config)

return config
