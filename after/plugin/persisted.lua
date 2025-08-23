vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require('telescope').load_extension("persisted")
vim.keymap.set("n", "<leader>p", function() vim.cmd(':Telescope persisted') end, { desc = '[p] Find Projects' })

require('persisted').setup({
  autoload = true,
  should_save = function()
    -- Do not save if the alpha dashboard is the current filetype
    return vim.bo.filetype ~= "snacks_dashboard" and not vim.bo.readonly and vim.bo.modifiable and
        vim.fn.getcwd() ~= "C:\\Program Files\\Neovide" and
        vim.fn.getcwd() ~= "~" and
        vim.fn.getcwd() ~= "/home/mmmaellon" and
        vim.fn.getcwd() ~= "/var/tmp"
  end,
})

-- forces it to still save session if we opened it by double-clicking a file
local persisted = require("persisted")
vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    -- Do nothing if Neovim was started as a pager (e.g., for a git commit)
    if vim.g.started_with_stdin then
      return
    end

    -- Capture the file arguments passed to the nvim command.
    -- We will check this *after* loading the session.
    local files_to_open = {}
    if vim.fn.argc() > 0 then
      for i = 0, vim.fn.argc() - 1 do
        local arg = vim.fn.argv(i)

        -- vim.notify("ARG " .. i .. ": " .. arg);

        -- We only care about arguments that are actual, readable files.
        -- This will ignore directories like '.' or 'src/'.
        if vim.fn.filereadable(arg) == 1 then
          table.insert(files_to_open, arg)
        end
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

    if #files_to_open > 0 then
      -- vim.fn.fnameescape is important to handle special characters in file paths.
      -- Open the first file and load it into the current window.
      vim.cmd("edit " .. vim.fn.fnameescape(files_to_open[1]))

      -- If there are more files, add them to the buffer list without opening them.
      for i = 2, #files_to_open do
        vim.cmd("badd " .. vim.fn.fnameescape(files_to_open[i]))
      end
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BufReadPost",
  callback = function(session)
    -- Save the currently loaded session passing in the path to the current session
    persisted.save({ session = vim.g.persisted_loaded_session })
    vim.notify("Saving Session");
    -- Delete all of the open buffers
    -- vim.api.nvim_input("<ESC>:%bd!<CR>")
  end,
})
