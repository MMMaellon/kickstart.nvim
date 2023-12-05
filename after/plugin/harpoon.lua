local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>h", function() harpoon:list():append() end, {desc = "[H] Harpoon File"})
vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "[m] Harpoon Marks"})
vim.keymap.set("n", "<s-f1>", function() harpoon:list():select(1) end, {desc = "[<S-F1>] Jump to Harpoon File 1", })
vim.keymap.set("n", "<s-f2>", function() harpoon:list():select(2) end, {desc = "[<S-F2>] Jump to Harpoon File 2", })
vim.keymap.set("n", "<s-f3>", function() harpoon:list():select(3) end, {desc = "[<S-F3>] Jump to Harpoon File 3", })
vim.keymap.set("n", "<s-f4>", function() harpoon:list():select(4) end, {desc = "[<S-F4>] Jump to Harpoon File 4", })

