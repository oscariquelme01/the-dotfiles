---------------------------------------
-- All credits for this animation goes to github user andOrlando
-- Check his work at https://github.com/andOrlando/
--
-- Only thing I did here is comment the code to the  best of my ability so that anyone who finds it can have a basic understanding
---------------------------------------
local wibox = require 'wibox'
local rubato = require 'lib.rubato'
local awful = require 'awful'
local gears = require 'gears'
local dpi   = require 'beautiful'.xresources.apply_dpi

return function(action)

    local function get_draw_function(pos)
        return function(_, _, cr, _, height)
            -- Set color and line width
            -- Color is theme.white manually converted
            -- cr:set_source_rgb(0.45098, 0.47451, 0.58039) -- theme.dark_grey
            cr:set_source_rgb(0.84314, 0.85490, 0.87843)
            cr:set_line_width(0.1 * height)

            --top, middle, bottom, left, right, radius, radius/2 pi*2
            local t, m, b, l, r, ra, ra2, pi2
            t = 0.3 * height
            m = 0.5 * height
            b = 0.7 * height
            l = 0.25 * height
            r = 0.75 * height
            ra = 0.05 * height
            ra2 = ra/2
            pi2 = math.pi * 2

            -- The rubato lib will interpolate between 0 and 1 (because target is set to either one or 0 below)
            -- if pos is equal or less than 0.5, we are in the situation where the 3 hamburger things are already overlapped
            -- This means we gotta start with the rotation
            if pos <= 0.5 then

                -- find the position to which the top and bottom lines will rotate
                local tpos = t+(m-t)*pos
                local bpos = b - (b - m) * pos

                pos = pos * 2

                -- Draw and fill the new rotated arcs.
                -- Maths here are a bit tricky to understand but if you really need to understand them, check cairo docs
                -- https://www.cairographics.org/documentation/

                cr:arc(l, tpos, ra, 0, pi2)
                cr:arc(r, tpos, ra, 0, pi2)
                cr:fill()

                cr:arc(l, m, ra, 0, pi2)
                cr:arc(r, m, ra, 0, pi2)
                cr:fill()

                cr:arc(l, bpos, ra, 0, pi2)
                cr:arc(r, bpos, ra, 0, pi2)
                cr:fill()

                cr:move_to(l + ra2, tpos)
                cr:line_to(r - ra2, tpos)

                cr:move_to(l + ra2, m)
                cr:line_to(r - ra2, m)

                cr:move_to(l + ra2, bpos)
                cr:line_to(r - ra2, bpos)

                cr:stroke()

            -- if pos is greater than 0.5, it means that we are in the stage where we need to
            -- move up and down (or viceversa depending on the state)the top and bottom lines of the hamburger
            else
                pos = (pos - 0.5) * 2

                cr:move_to(l, m - (m - l) * pos)
                cr:line_to(r, m + (r - m) * pos)

                cr:move_to(l, m + (r - m) * pos)
                cr:line_to(r, m - (m - l) * pos)

                cr:stroke()
            end
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

    -- Main function to return.
    -- The action parameter is a callable containing the action that will be performed when the hamburger is clicked
    -- NOTE: In the original file by the author andOrlando, it is not a callable! it is an awful.button appended to buttons
    local w = wibox.widget {

        -- initial state is 0
        draw = get_draw_function(0),
        fit = function(_, _, _, height) return height, height end,
        buttons = gears.table.join(
            -- switch state
            awful.button({}, 1, toggle)
        ),
        -- IMPORTANT: original file didn't work for me until I set forced_height
        -- The reason is that I have a vertical wibar so it was getting an absurdly high height and since height = width
        -- The hamburger was not being displayed
        forced_height = dpi(40),
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
