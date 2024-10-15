local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

awful.screen.connect_for_each_screen(function(s)

    local icon_list = wibox.widget {
        layout = wibox.layout.flex.horizontal
    }

    local alt_tab_container = awful.popup {
        widget = {
            layout = icon_list,
        },
        border_color = beautiful.dark_grey,
        bg = beautiful.black,
        border_width = 2,
        ontop        = true,
        placement    = awful.placement.centered,
        shape        = gears.shape.rounded_rect,
        visible      = false,
        screen       = s
    }

    s.alt_tab = alt_tab_container
    s.alt_tab.icon_list = icon_list

    -- credits to the following github repo for this function
    -- https://github.com/troglobit/awesome-switcher
    -- this function returns the list of clients to be shown.
    local function get_clients()
        local clients = {}

        -- Get focused screen
        local scr = awful.screen.focused();

        local idx = 0
        local c = awful.client.focus.history.get(scr, idx)

        while c do
            table.insert(clients, c)

            idx = idx + 1
            c = awful.client.focus.history.get(scr, idx)
        end

        -- Minimized clients will not appear in the focus history
        -- Find them by cycling through all clients, and adding them to the list
        -- if not already there.
        -- This will preserve the history AND enable you to focus on minimized clients

        local t = scr.selected_tag
        local all = client.get(scr)

        for i = 1, #all do
            c = all[i]
            local ctags = c:tags();

            -- check if the client is on the current tag
            local isCurrentTag = false
            for j = 1, #ctags do
                if t == ctags[j] then
                    isCurrentTag = true
                    break
                end
            end

            if isCurrentTag then
                -- check if client is already in the history
                -- if not, add it
                local addToTable = true
                for k = 1, #clients do
                    if clients[k] == c then
                        addToTable = false
                        break
                    end
                end


                if addToTable then
                    table.insert(clients, c)
                end
            end
        end

        return clients
    end

    -- Variable to store the state of the alt tab
    local index
    -- boolean to check whether alt tab was pressed when no clients were available
    local no_clients
    -- Variables to keep track of the previous client that the index accessed
    local previous_index
    local previous_client
    -- Variable storing all the clients for the current tag
    local clients
    -- Variable storing the screen in which the popup will be displayed
    local screen

    local start_callback = function ()
        clients = get_clients()

        -- Get the screen in which the popup will appear
        screen = awful.screen.focused()

        no_clients = false
        if #clients == 0 then no_clients = true return end

        for i = 1, #clients do

            -- create icon widget
            local icon = awful.widget.clienticon(clients[i])
            icon.forced_width = 80
            icon.forced_height = 80

            -- create the container for the icon
            local icon_container = wibox.widget{
                -- icon,
                {
                    icon,
                    widget = wibox.container.margin,
                    margins = dpi(12)
                },
                widget = wibox.container.background,
                forced_height = 100, forced_width = 100,
                bg = beautiful.black
            }

            screen.alt_tab.icon_list:add(icon_container)
        end

        -- set index as 2 so that alt tab starts at the second to last focused client in case there are more than one client
        if #clients > 1 then index = 2 else index = 1 end

        screen.alt_tab.visible = true
    end

    local stop_callback = function ()
        if no_clients then return end


        screen.alt_tab.visible = false

        -- Set the children to an empty table.
        -- TODO: check if this leaves unfreed memory
        screen.alt_tab.icon_list:set_children({})

        -- Set the previous client variable to nil for the next alt tab press
        previous_client = nil

        -- Update the focused client to the selected index
        local c = clients[previous_index]

        if c.minimized then c.minimized = false end
        client.focus = c

    end


    local update_callback = function ()
        if no_clients then return end

        -- this is necesary for the first iteration as the previous_client variable is first set some lines below
        if previous_client then previous_client.bg = beautiful.black end

        -- update background
        screen.alt_tab.icon_list.children[index].bg = beautiful.yellow

        previous_client = icon_list.children[index]
        previous_index = index
        -- update index for the next tab press
        index = index % #screen.alt_tab.icon_list.children + 1

    end

    awful.keygrabber {
        keybindings = {
        {{ modkey }, "d", update_callback},
        },
        -- Note that it is using the key name and not the modifier name.
        stop_key           = modkey,
        stop_event         = 'release',
        start_callback     = start_callback,
        stop_callback      = stop_callback,
        export_keybindings = true,
    }

end)
