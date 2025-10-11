vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require('telescope').load_extension("persisted")
vim.keymap.set("n", "<leader>p", function() vim.cmd(':Telescope persisted') end, { desc = '[p] Find Projects' })

function buffer_filter(b)
  if vim.bo[b].readonly or not vim.bo[b].modifiable then
    return false
  end
  if vim.tbl_contains({"nofile", "nowrite"}, vim.bo[b].buftype) or vim.tbl_contains({ "gitcommit", "gitrebase", "fugitive", "snacks_dashboard" }, vim.bo[b].filetype) or vim.tbl_contains({"C:\\Program Files\\Neovide", "~", "/home/mmmaellon", "/var/tmp"}, vim.fn.getcwd()) then
    return false
  end
  return vim.api.nvim_buf_get_name(b) ~= ""
end

require('persisted').setup({
  autoload = true,
  should_save = function()
    local bufs = vim.tbl_filter(buffer_filter, vim.api.nvim_list_bufs())
    return #bufs >= 1
  end,
})

-- forces it to still save session if we opened it by double-clicking a file
local persisted = require("persisted")
local file_opened_from_arg = "";
vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    -- Do nothing if Neovim was started as a pager (e.g., for a git commit)
    if vim.g.started_with_stdin then
      return
    end

    -- -- Capture the file arguments passed to the nvim command.
    -- -- We will check this *after* loading the session.
    -- local files_to_open = {}
    -- if vim.fn.argc() > 0 then
    --   for i = 0, vim.fn.argc() - 1 do
    --     local arg = vim.fn.argv(i)
    --
    --     vim.notify("ARG " .. i .. ": " .. arg);
    --
    --     -- We only care about arguments that are actual, readable files.
    --     -- This will ignore directories like '.' or 'src/'.
    --     if vim.fn.filereadable(arg) == 1 then
    --       vim.notify("Adding to the list of files to open: " .. arg);
    --       table.insert(files_to_open, arg)
    --     end
    --   end
    -- end
    if vim.fn.argc() > 0 then
      for i = 0, vim.fn.argc() - 1 do
        local arg = vim.fn.argv(i)
        file_opened_from_arg = vim.fn.getcwd() .. "/" .. vim.fn.fnameescape(arg)
      end
    end

    local forceload = false
    if vim.fn.argc() == 0 then
      forceload = true
    elseif vim.fn.argc() == 1 then
      local dir = vim.fn.expand(vim.fn.argv(0))
      if dir == '.' then
        dir = vim.fn.getcwd()
      end

      forceload = true
    end

    persisted.autoload({ force = forceload })
    -- persisted.load();

    -- if #files_to_open > 0 then
    --   -- vim.fn.fnameescape is important to handle special characters in file paths.
    --   -- Open the first file and load it into the current window.
    --   vim.notify("Opening: " .. vim.fn.fnameescape(files_to_open[1]));
    --   vim.cmd("vsplit " .. vim.fn.fnameescape(files_to_open[1]))
    --
    --   -- If there are more files, add them to the buffer list without opening them.
    --   for i = 2, #files_to_open do
    --     vim.notify("Adding to Buffers: " .. files_to_open[i]);
    --     vim.cmd("badd " .. vim.fn.fnameescape(files_to_open[i]))
    --   end
    -- end
  end,
})

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "PersistedSavePre",
--   callback = function()
--     for buf in filter_buffers(true) do
--       vim.api.nvim_buf_delete(buf, { force = true })
--     end
--   end,
-- })

local persisted_started = false
vim.api.nvim_create_autocmd("User", {
  pattern = "PersistedLoadPost",
  callback = function(session)
    local duplicate_file = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local filename = vim.api.nvim_buf_get_name(buf)
      if(filename == file_opened_from_arg) then
        local winid = vim.fn.bufwinid(buf)
        if winid ~= -1 then
          -- Buffer loaded and visible
          -- Swap to the correct window
          vim.api.nvim_set_current_win(winid)
          duplicate_file = true
        end
      end
      if not buffer_filter(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
    if not duplicate_file and file_opened_from_arg ~= "" and  vim.fn.filereadable(file_opened_from_arg) == 1 then
      vim.cmd("vsplit " .. file_opened_from_arg);
      file_opened_from_arg = ""
    end
    vim.cmd("wincmd =")
  end,
})

vim.api.nvim_create_autocmd("WinNew", {
  callback = function(session)
    -- Save the currently loaded session passing in the path to the current session
    local opened_buf_id = session.buf
    local opened_filename = vim.api.nvim_buf_get_name(opened_buf_id)
    if persisted_started and opened_filename ~= "" then
      persisted.save({ session = vim.g.persisted_loaded_session })
    end
    -- vim.notify("Saving Session");
    -- Delete all of the open buffers
    -- vim.api.nvim_input("<ESC>:%bd!<CR>")
  end,
})
vim.api.nvim_create_autocmd("WinClosed", {
  callback = function(session)
    local open_windows = vim.api.nvim_list_wins();
    local window_count = 0;
    local closed_buf_id = session.buf
    local closed_filename = vim.api.nvim_buf_get_name(closed_buf_id)
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
      local buf_id = vim.api.nvim_win_get_buf(win_id)
      local filename = vim.api.nvim_buf_get_name(buf_id)
      if filename ~= "" and filename ~= closed_filename then
        window_count = window_count + 1;
      end
    end
    if window_count > 0 then
      persisted.save({ session = vim.g.persisted_loaded_session })
    end
  end,
})
