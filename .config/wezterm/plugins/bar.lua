local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
	bar.apply_to_config(config, {
		max_width = 32,
		padding = {
			left = 2,
			right = 2,
		},
		separator = {
			space = 1,
			left_icon = wezterm.nerdfonts.fa_long_arrow_right,
			right_icon = wezterm.nerdfonts.fa_long_arrow_left,
			field_icon = wezterm.nerdfonts.indent_line,
		},
		modules = {
			tabs = {
				active_tab_fg = 3, -- index into ansi/brights palette
				inactive_tab_fg = 9,
			},
			workspace = {
				enabled = true,
				icon = wezterm.nerdfonts.cod_window,
				color = 8,
			},
			leader = {
				enabled = true,
				icon = wezterm.nerdfonts.oct_rocket,
				color = 2,
			},
			pane = {
				enabled = false,
			},
			username = {
				enabled = false,
			},
			hostname = {
				enabled = false,
			},
			clock = {
				enabled = false,
			},
			cwd = {
				enabled = false,
			},
		},
	})

	-- COPY MODE status bar
	wezterm.on('update-status', function(window, pane)
		local key_table = window:active_key_table()
		if key_table == 'copy_mode' or key_table == 'search_mode' then
			window:set_right_status(wezterm.format {
				{ Background = { AnsiColor = 'Black' } },
				{ Foreground = { AnsiColor = 'Red' } },
				{ Attribute = { Intensity = 'Bold' } },
				{ Text = ' ' .. string.upper(key_table:gsub('_', ' ')) .. ' ' },
			})
		else
			window:set_right_status('')
		end
	end)
end

return M
