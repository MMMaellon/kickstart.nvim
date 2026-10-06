return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/Obsidian Vault",
      },
      {
        name = "work",
        path = "~/Documents/Obsidian-WorkVault",
      },
    },
    picker = {
      name = "telescope.nvim"
    },
    image = {
      resolve = function (path, src)
        local api = require "obsidian.api"
        if api.path_is_note(path) then
          return api.resolve_attachment_path(src)
        end
      end,
    },
    daily_notes = {
      enabled = true,
      folder = "Dailies",
      date_format = "YYYY/YYYY-MM-DD",
      default_tags = {"journal", "daily"},
    }
  },
}
