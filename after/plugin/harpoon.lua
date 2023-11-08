local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>h", mark.add_file, {desc = "[H] Harpoon File"})
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu, {desc = "[m] Harpoon Marks"})
vim.keymap.set("n", "<s-f1>", function() ui.nav_file(1) end, {desc = "[<S-F1>] Jump to Harpoon File 1", })
vim.keymap.set("n", "<s-f2>", function() ui.nav_file(2) end, {desc = "[<S-F2>] Jump to Harpoon File 2", })
vim.keymap.set("n", "<s-f3>", function() ui.nav_file(3) end, {desc = "[<S-F3>] Jump to Harpoon File 3", })
vim.keymap.set("n", "<s-f4>", function() ui.nav_file(4) end, {desc = "[<S-F4>] Jump to Harpoon File 4", })

