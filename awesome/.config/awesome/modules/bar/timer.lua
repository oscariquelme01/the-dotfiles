-- Create a widget and update its content using the output of a shell
-- command every 10 seconds:
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local timerStoppedText = "-------"
local timerText = "01:00" --3600 seconds because I will work 1 hour sprints

local timerInitialValue = "3600" -- a string cause fuck the system

-- format newTime in seconds to HH:MM format
local function formatTime(newTime)
	return string.format("%02d:%02d", math.floor(newTime / 3600), math.floor(newTime / 60))
end

return function()
	-- update every 60 seconds
	local frequencyToUpdate = 1

	local timer = wibox.widget({
		text = timerStoppedText,
		paddings = 1,
		border_width = 1,
		forced_width = 32,
		border_color = beautiful.border_normal,
		widget = wibox.widget.textbox,
	})

	local awesomeTimer = gears.timer({
		timeout = frequencyToUpdate,
		call_now = false,
		autostart = false,
		callback = function()
			local currentTimeLeft = tonumber(timer.currentTimeLeft or timerInitialValue)
			local newTime = currentTimeLeft - frequencyToUpdate
			if newTime >= 0 then
				timer.text = formatTime(newTime)
				timer.currentTimeLeft = newTime
			else
				awesomeTimer:stop()
			end
		end,
	})

	timer:buttons(gears.table.join(
		timer:buttons(),
		awful.button({}, 1, nil, function()
			if timer.text == timerStoppedText then
				timer.text = timerText
				timer.currentTimeLeft = timerInitialValue
				naughty.notify({text = "Timer started!"})
				awesomeTimer:start()
			else
				naughty.notify({text = "Timer stopped!"})
				timer.text = timerStoppedText
				awesomeTimer:stop()
			end
		end)
	))

	return timer
end
