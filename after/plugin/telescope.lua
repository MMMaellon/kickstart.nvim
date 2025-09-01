-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local builtin = require('telescope.builtin')
local Path = require "plenary.path"
local trouble = require("trouble.providers.telescope")

-- utility to get absolute path of target directory for create, copy, moving files/folders
local get_target_dir = function(finder)
  local entry_path = vim.cmd("pwd");
  if finder.files == false then
    local entry = action_state.get_selected_entry()
    entry_path = entry and entry.value -- absolute path
  end
  return finder.files and finder.path or entry_path
end

local search_current_path = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder

  local base_dir = get_target_dir(finder) .. Path.path.sep
  builtin.find_files({ cwd = base_dir })
end

local browse_current_path = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder

  local base_dir = get_target_dir(finder) .. Path.path.sep
  -- builtin.find_files({ cwd = base_dir })
  vim.cmd(':Telescope file_browser path=' .. base_dir .. ' select_buffer=true<CR>')
end


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
        -- ["<C-t>"] = trouble.open_with_trouble,
        ['<C-f>'] = browse_current_path,
      },
      -- n = {
      --   ["<C-t>"] = trouble.open_with_trouble,
      -- }
    },
    path_display = { shorten = {len = 4, exclude = {1, -1}} },
  },
  extensions = {
    file_browser = {
      -- theme = 'ivy',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      prompt_path = true,
      select_buffer = true,
      grouped = true,
      respect_gitignore = false,
      hidden = { file_browser = true, folder_browser = true },
      -- auto_depth = true,
      -- depth= 3,
      mappings = {
        ["n"] = {
          ["<C-f>"] = search_current_path,
        },
        ["i"] = {
          ["<C-f>"] = search_current_path,
        },
        -- ["c"] = {
        --   ["<c-f>"] = search_current_path,
        -- }
      }
    },
  },
}

-- To get telescope-file-browser loaded and working with telescope,
require('telescope').load_extension 'file_browser'

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- See `:help telescope.builtin`

vim.keymap.set('n', '<leader><leader>', ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
  { noremap = true, desc = 'File Browser' })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = '[f] Find Files' })
-- vim.keymap.set("n", "<leader>p", function() vim.cmd(':Telescope projects') end, { desc = '[p] Find Projects' })
vim.keymap.set("n", "<leader>gg", builtin.git_files, { desc = '[g] Find Git Files' })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = '[b] Find Buffers' })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = '[h] Find Help Tags' })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = '[g] Live Grep' })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = '[d] Find diagnostics' })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = '[w] Find Selected Word' })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = '[r] Resume Last Search' })

local localSearch = function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    -- previewer = false,
  })
end

vim.keymap.set('n', '<leader>/', localSearch, { desc = '[/] Fuzzily search in current buffer' })
-- vim.keymap.set({ 'n', 'i', 'v' }, '<c-f>', localSearch)
