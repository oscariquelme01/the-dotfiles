local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

local bling = require("lib.bling")

local icons = require("icons")

return function(s, orientation)
    -- buttons to enable mouse navigation
    local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    -- icons for each situation
    local focus = gears.surface.load_uncached(icons.ghost)
    local unfocus = gears.color.recolor_image(gears.surface.load_uncached(icons.scared_ghost), beautiful.grey)
    local empty = gears.color.recolor_image(gears.surface.load_uncached(icons.circle), beautiful.grey)

    local function update_callback(self, tag, _, _)
        local tag_icon = self:get_children_by_id('icon_role')[1]

        -- switch icon depending on the tag situation
        if tag.selected then
            tag_icon.image = gears.color.recolor_image(focus, beautiful.tag_colors[tonumber(tag.name)])
        elseif #tag:clients() == 0 then
            tag_icon.image = empty
        else
            tag_icon.image = unfocus
        end
    end

    local function create_callback(self, tag, _, _)
        -- initial update
        update_callback(self, tag, _, _)

        --- Tag preview not working currently for some reason
        self:connect_signal("mouse::enter", function()
            if #tag:clients() > 0 then
                awesome.emit_signal("bling::tag_preview::update", tag)
                awesome.emit_signal("bling::tag_preview::visibility", s, true)
            end
        end)

        self:connect_signal("mouse::leave", function()
            awesome.emit_signal("bling::tag_preview::visibility", s, false)
        end)
    end


    -- Setup tags and default layout, the name can't be changed because it is used to change the colors of the focused taglist
    awful.tag({ "1", "2", "3", "4", "5"}, s, bling.layout.equalarea)
    local layout
    if orientation == 'vertical' then
        layout = wibox.layout.fixed.horizontal
    else
        layout = wibox.layout.fixed.vertical
    end

    -- actual taglist containing just an icon and the margin for each tag
    local taglist = awful.widget.taglist({
        screen          = s,
        filter          = awful.widget.taglist.filter.all,
        style           = { shape = gears.shape.rounded_rect },
        layout          = { spacing = 0, layout = layout },
        widget_template = {
            {
                { id = 'icon_role', widget = wibox.widget.imagebox, forced_height = dpi(30), forced_width = dpi(30) },
                id = 'margin_role',
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(8),
                right = dpi(8),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = create_callback,
            update_callback = update_callback,
        },
        buttons         = taglist_buttons
    })

    return taglist
end
