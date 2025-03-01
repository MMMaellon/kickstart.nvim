vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require('telescope').load_extension("persisted")
vim.keymap.set("n", "<leader>p", function() vim.cmd(':Telescope persisted') end, { desc = '[p] Find Projects' })

require('persisted').setup({
  autoload = true,
  should_save = function()
    -- Do not save if the alpha dashboard is the current filetype
    return vim.bo.filetype ~= "snacks_dashboard" and not vim.bo.readonly and vim.bo.modifiable and
        vim.fn.getcwd() ~= "C:\\Program Files\\Neovide"
  end,
})

-- forces it to still save session if we opened it by double-clicking a file
local persisted = require("persisted")
-- vim.api.nvim_create_autocmd("VimEnter", {
--   nested = true,
--   callback = function()
--     if vim.g.started_with_stdin then
--       return
--     end
--
--     local forceload = false
--     if vim.fn.argc() == 0 then
--       forceload = true
--     elseif vim.fn.argc() == 1 then
--       local dir = vim.fn.expand(vim.fn.argv(0))
--       if dir == '.' then
--         dir = vim.fn.getcwd()
--       end
--
--       forceload = true
--     end
--
--     persisted.autoload({ force = forceload })
--   end,
-- })
