local wezterm = require("wezterm")

local is_mac = wezterm.target_triple:find("darwin") ~= nil

local M = {}

M.mod = is_mac and "CMD" or "CTRL"

function M.add_keys(config, keys)
	for _, k in ipairs(keys) do
		table.insert(config.keys, k)
	end
end

function M.dump(o, indent)
    indent = indent or ""
    if type(o) ~= "table" then
        if type(o) == "string" then
            return string.format("%q", o)
        else
            return tostring(o)
        end
    end

    local next_indent = indent .. "  "
    local lines = { "{" }
    for k, v in pairs(o) do
        local key
        if type(k) == "string" then
            key = string.format("[%q]", k)
        else
            key = "[" .. tostring(k) .. "]"
        end
        table.insert(lines, next_indent .. key .. " = " .. M.dump(v, next_indent) .. ",")
    end
    table.insert(lines, indent .. "}")
    return table.concat(lines, "\n")
end

return M
