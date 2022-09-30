---------------------------------------
-- All credits for this animation goes to github user andOrlando
-- Check his work at https://github.com/andOrlando/
--
-- Only thing I did here is comment the code to the  best of my ability so that anyone who finds it can have a basic understanding
---------------------------------------
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local rubato = require("lib.rubato")
local dpi = require("beautiful").xresources.apply_dpi

return function(action)

    local function get_draw_function(pos)
        return function(_, _, cr, width, height)
            -- Set color and line width
            -- Color is theme.white manually converted
            -- cr:set_source_rgb(0.45098, 0.47451, 0.58039) -- theme.dark_grey
            cr:set_source_rgb(0.84314, 0.85490, 0.87843)
            cr:set_line_width(0.1 * height)

            -- this variables contain the starting point for the two lines that will be animated
            local left, right
            left = 0
            right = width
            -- this are the vertical and horizontal center point of the whole cairo surface
            local middle_height, middle_width
            middle_height = height/2
            middle_width = width/2

            -- 200 iq move right here
            cr:move_to(left, middle_height)
            cr:line_to(middle_width, height*pos)

            -- draw the right line
            cr:move_to(right, middle_height)
            cr:line_to(middle_width, height*pos)

            cr:stroke()
        end
    end


    local timed

    -- Function to switch the state when clicked, separated from the wibox.widget definition because I need to keep a reference
    -- so that I can set a keybind to toggle the control pannel
    local toggle = function()
        if timed.running then return end

        timed.target = (timed.target + 1) % 2

        -- action to be performed when the hamburger is clicked
        action()
    end

    -- Main widget to return.
    -- The action parameter is a callable containing the action that will be performed when the hamburger is clicked
    -- NOTE: In the original file by the author andOrlando, it is not a callable! it is an awful.button appended to buttons
    local w = wibox.widget {

        -- initial state is 0
        draw = get_draw_function(0),
        fit = function(_, _, width, height) return width, height end,
        buttons = gears.table.join(
            -- switch state
            awful.button({}, 1, toggle)
        ),
        -- IMPORTANT: original file didn't work for me until I set forced_height
        -- The reason is that I have a vertical wibar so it was getting an absurdly high height and since height = width
        -- The hamburger was not being displayed
        forced_height = dpi(40),
        forced_width = dpi(10),
        widget = wibox.widget.make_base_widget
    }

    timed = rubato.timed {
        duration = 0.4,
        intro = 0.3,
        prop_intro = true,
        rate = 30,
        subscribed = function(pos)
            w.draw = get_draw_function(pos)
            w:emit_signal("widget::redraw_needed")
        end
    }

    w.toggle = toggle

    return w

end
