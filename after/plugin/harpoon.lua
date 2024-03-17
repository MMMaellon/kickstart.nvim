local harpoon = require("harpoon")
-- REQUIRED
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
-- REQUIRED
vim.keymap.set("n", "<leader>h", function() harpoon:list():append() end, {desc = "[H] Harpoon File"})
vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "[m] Harpoon Marks"})
vim.keymap.set("n", "<s-f1>", function() harpoon:list():select(1) end, {desc = "[<S-F1>] Jump to Harpoon File 1", })
vim.keymap.set("n", "<s-f2>", function() harpoon:list():select(2) end, {desc = "[<S-F2>] Jump to Harpoon File 2", })
vim.keymap.set("n", "<s-f3>", function() harpoon:list():select(3) end, {desc = "[<S-F3>] Jump to Harpoon File 3", })
vim.keymap.set("n", "<s-f4>", function() harpoon:list():select(4) end, {desc = "[<S-F4>] Jump to Harpoon File 4", })

