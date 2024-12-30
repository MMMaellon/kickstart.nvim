local snacks = require('snacks');
-- local config = require('snacks.config')
snacks.config.dashboard.preset = {
  keys = {
    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
    { icon = " ", key = "l", desc = "Last Session", action = ":lua require('persistence').load({ last = true })" },
    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
  }
}
local gif_path = vim.fn.stdpath("config") .. "/resources/transparent_fauna_loop.gif"
snacks.config.dashboard.sections = {

  {
    section = "terminal",
    cmd = string.format(
      "chafa %s --symbols block+half+wide+space+ascii --colors full --fit-width -w 9 --clear --exact-size false --fg-only --margin-bottom 10 --bg 88DDAA",
      gif_path),
    width = 60,
    height = 30,
    indent = 0,
    padding = 1,
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
  { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
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

snacks.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  -- notifier = { enabled = true },
  quickfile = { enabled = true },
  -- scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}


vim.api.nvim_create_user_command("Dashboard", Snacks.dashboard.open, {})
