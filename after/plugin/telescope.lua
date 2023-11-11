-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    theme = "center",
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-h>'] = "which_key",
        ['<Tab>'] = "select_tab",
      },
    },
  },
  extensions = {
    file_browser = {
      -- theme = 'ivy',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      prompt_path = true,
      select_buffer = true,
      grouped = true,
      auto_depth = true,
    },
  },
}

-- To get telescope-file-browser loaded and working with telescope,
require('telescope').load_extension 'file_browser'

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = '[f] Find Files'})
vim.keymap.set("n", "<leader>fp", function () vim.cmd(':Telescope projects') end, {desc = '[p] Find Projects'})
vim.keymap.set("n", "<leader>gg", builtin.git_files, {desc = '[g] Find Git Files'})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {desc = '[b] Find Buffers'})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {desc = '[h] Find Help Tags'})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc = '[g] Live Grep'})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {desc = '[d] Find diagnostics'})
vim.keymap.set("n", "<leader>fw", builtin.grep_string, {desc = '[w] Find Selected Word'})
vim.keymap.set("n", "<leader>fr", builtin.resume, {desc = '[r] Resume Last Search'})

local localSearch = function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    -- previewer = false,
  })
end

vim.keymap.set('n', '<leader>/', localSearch, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set({'n', 'i', 'v'}, '<c-f>', localSearch)
