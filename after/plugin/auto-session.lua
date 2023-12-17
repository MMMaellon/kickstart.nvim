require("auto-session").setup {
  log_level = vim.log.levels.ERROR,
  auto_session_suppress_dirs = { "~/", "~/Downloads", "/", "C:/", "D:/", "C:/Program Files/Neovide", "C:\\Program Files\\Neovide"},
  auto_session_use_git_branch = false, -- messes stuff up

  auto_session_enable_last_session = false,

  -- ⚠️ This will only work if Telescope.nvim is installed
  -- The following are already the default values, no need to provide them if these are already the settings you want.
  session_lens = {
    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
    buftypes_to_ignore = {'dashboard', 'nowrite', 'fugitive', 'gitcommit', 'git', 'undotree'}, -- list of buffer types what should not be deleted from current session
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
  post_restore_cmds = {
    "BWipeout! hidden",
    "bufdo! e",
  },
}

-- Set mapping for searching a session.
-- ⚠️ This will only work if Telescope.nvim is installed
vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, {
  noremap = true, desc = "Find [S]ession",
})

-- recomended setting idk what it does
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
