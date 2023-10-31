local module = {}
local wezterm = require('wezterm')
local mux = wezterm.mux

local json = require('../lib/json')

local home = os.getenv('HOME') .. '/'
local defaultPath = home .. '.local/share/weztermWorkspaces.json'

local loadWorkspacesData = function ()
  local file = io.open(defaultPath, "r")
  if file ~= nil then
    local jsonString = file:read("a")
    local workspaces = json.parse(jsonString)
    file:close()

    return workspaces
  else
    error('No workspace json file found')
  end
end

-- theoretically this function will only be executed with an empty tab 
-- this function runs assuming the following
-- -> the tab only has one single pane
-- -> this first pane can be closed right after splitting because the API of wezterm doesn't allow for a clean cd with an already created pane
local function createPanes(tab, panes, initialSize)
  local initialCols = initialSize.cols
  local initialRows = initialSize.rows
  local firstPane = tab:panes()[1]

  if #panes == 1 then
    return
  end

  local nextPane
  for paneIndex = 1, #panes - 1, 1 do
    local paneInfo = panes[paneIndex]
    local nextPaneInfo = panes[paneIndex + 1]
    local direction, size
    if paneInfo.left == nextPaneInfo.left then
      direction = 'Bottom'
      size = paneInfo.width / initialCols
    else
      direction = 'Right'
      size = paneInfo.height / initialRows
    end

    if paneIndex == 1 then
      nextPane = firstPane:split { cwd = paneInfo.cwd, direction = direction, size = size }
    else
      nextPane = nextPane:split { cwd = paneInfo.cwd, direction = direction, size = size }
    end
  end
end

-- transforms an object representing the workspaces into actual workspaces
local function createWorkspaces(workspaces, initialSize)
  for _, workspace in ipairs(workspaces) do

    local firstTab, _, window = mux.spawn_window {
      workspace = workspace.label
    }

    for tabIndex, tab in ipairs(workspace.tabs) do
      local newtab
      if tabIndex == 1 then newtab = firstTab
      else newtab, _, _ = window:spawn_tab {} end

      -- set title back only if it was explicitly set 
      if #tab.label ~= 0 then
        newtab:set_title(tab.label)
      end

      createPanes(newtab, tab.panes, initialSize)
    end
  end
end

function module.loadWorkspaces(initialSize)
  local workspaces = loadWorkspacesData()
  createWorkspaces(workspaces, initialSize)
end

local function formatPanes(panes)
  local ret = {}
  for paneIndex, pane in ipairs(panes) do
    ret[paneIndex] = {}
    ret[paneIndex].height = pane.height
    ret[paneIndex].width = pane.width
    ret[paneIndex].top = pane.top
    ret[paneIndex].left = pane.left
    local url = pane.pane:get_current_working_dir()
    local cwd = wezterm.url.parse(url).path
    ret[paneIndex].cwd = cwd
  end

  return ret
end

local function formatTabs(tabs)
    local ret = {}
    for tabIndex, tab in ipairs(tabs) do
      ret[tabIndex] = {}
      ret[tabIndex].label = tab:get_title()

      local panes = tab:panes_with_info()
      ret[tabIndex].panes = formatPanes(panes)
    end

  return ret
end

local function writeWorkspacesToJSON(workspaces)
  local file = io.open(defaultPath, "w")
  file:write(json.stringify(workspaces))
  file:close()
end

function module.saveWorkspaces()
  local workspaces = {} -- object to represent all the workspaces

  local windows = mux.all_windows()
  for windowIndex, window in ipairs(windows) do
    workspaces[windowIndex] = {}
    workspaces[windowIndex].label = window:get_workspace()
    local tabs = window:tabs()
    workspaces[windowIndex].tabs = formatTabs(tabs)
  end
  writeWorkspacesToJSON(workspaces)
end

return module
