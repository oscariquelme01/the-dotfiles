local gears = require("gears")

local M = {}

function M.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


-- Function meant to colorize the text of a widget.textbox using the its markup system
M.colorize_text = function(text, color)
    return "<span foreground='" .. color .."'>" .. text .. "</span>"
end


-- Create rounded rectangle with the specified radius
function M.rounded_rect(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

-- Splits the string by separator
-- @return table with separated substrings
function M.split(string_to_split, separator)
    if separator == nil then separator = "%s" end
    local t = {}

    for str in string.gmatch(string_to_split, "([^".. separator .."]+)") do
        table.insert(t, str)
    end

    return t
end


-- Checks if a string starts with a another string
function M.starts_with(str, start)
    return str:sub(1, #start) == start
end

-- Helper function to help me debug
function M.log(o)
    local file = io.open("log.txt", "a")

    if type(o) == 'boolean' then
        file:write(tostring(o))
        file:close()
        return
    end

    if type(o) == 'string' or type(o) == 'number' then
         file:write(o)
         file:close()
    elseif type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.log(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end

end

return M
