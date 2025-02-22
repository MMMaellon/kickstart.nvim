local snacks = require('snacks');
-- local config = require('snacks.config')
snacks.config.dashboard.preset = {
  keys = {
    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
    -- { icon = " ", key = "l", desc = "Last Session", action = ":lua require('persistence').load({ last = true })" },
    { icon = " ", key = "l", desc = "Last Session", action = ":lua require('persisted').load({ last = true })" },
    { icon = " ", key = "r", desc = "Recent Projects", action = ":Telescope persisted" },
    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
  }
}

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

local gif_path = vim.fn.stdpath("config") .. "/resources/transparent_fauna_loop.gif"
local persisted = require("persisted")
local persisted_sessions = function()
  local dirs = {}
  local files = persisted.list()
  -- print(dump(files))
  for _, file in pairs(files) do
    file = file:gsub("(.*).vim", "%1")
    local dir, branch = unpack(vim.split(file, "@@", { plain = true }))
    dir = dir:gsub(".*\\", "")
    dir = dir:gsub("%%", "\\")
    dir = dir:gsub("([A-Za-z])[\\/](.*)", "%1:/%2")
    dir = dir:gsub("\\", "/")
    if branch ~= nil and branch ~= '' then
      dir = dir .. " : " .. branch
    end
    table.insert(dirs, dir)
  end
  return dirs
end

local open_persisted = function(proj)
  local dir, branch = unpack(vim.split(proj, " : ", { plain = true }))
  local utils = require('persisted.utils')
  local config = require('persisted.config')
  local dir = utils.make_fs_safe(dir)

  if config.use_git_branch and persisted.opts.branch ~= false then
    if branch then
      dir = dir .. "@@" .. branch
    end
  end

  local vim_file = config.save_dir .. dir .. ".vim"
  persisted.load({ session = vim_file })
end

snacks.config.dashboard.sections = {
  {
    section = "terminal",
    cmd = string.format(
      "chafa %s --symbols block+half+wide+space+ascii --colors full --clear --fit-width -w 9 --fg-only --bg %s",
      gif_path, vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
    ),
    width = 55,
    height = 30,
    indent = 3,
    padding = 1,
    align = "center",
    enabled = function()
      return vim.o.columns <= 300
    end
  },
  {
    section = "terminal",
    cmd = string.format(
      "chafa %s --symbols block+half+wide+space+ascii --colors full --clear --fit-width -w 9 --fg-only --bg %s",
      gif_path, vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
    ),
    -- width = 60,
    height = 30,
    -- indent = 3,
    padding = 1,
    align = "center",
    enabled = function()
      return vim.o.columns > 300
    end
  },
  -- {
  --   pane = 2,
  --   section = "terminal",
  --   cmd = "colorscript -e square",
  --   height = 5,
  --   padding = 1,
  -- },
  { pane = 2, title = "", section = "keys", gap = 1, padding = 6 },
  { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
  {
    pane = 2,
    icon = " ",
    title = "Projects",
    section = "projects",
    indent = 2,
    padding = 1,
    dirs = persisted_sessions,
    action = open_persisted,
  },
  -- {
  --   pane = 2,
  --   icon = " ",
  --   title = "Git Status",
  --   section = "terminal",
  --   enabled = function()
  --     return Snacks.git.get_root() ~= nil
  --   end,
  --   cmd = "git status --short --branch --renames",
  --   height = 5,
  --   padding = 1,
  --   ttl = 5 * 60,
  --   indent = 3,
  -- },
  { section = "startup" },
}

snacks.config.notifier.timeout = 10000 -- 10 seconds default
snacks.config.notifier.style = "fancy"


snacks.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  indent = {
    enabled = true,
    scope = {
      enabled = true,
      only_scope = true,
      only_current = true,
    },
    indent = {
      only_current = true,
    }
  },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  -- scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}

vim.api.nvim_create_user_command("Clear", function()
  Snacks.notifier.hide()
end, {})
vim.api.nvim_create_user_command("Messages", function() Snacks.notifier.show_history() end, {})
vim.api.nvim_create_user_command("Dashboard", Snacks.dashboard.open, {})
