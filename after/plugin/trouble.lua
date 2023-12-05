

local trouble = require("trouble")

vim.keymap.set("n", "<leader>tt", function() trouble.toggle() end, {desc = "[T]rouble"})
vim.keymap.set("n", "<leader>tw", function() trouble.toggle("workspace_diagnostics") end, {desc = "[W]orkspace"})
vim.keymap.set("n", "<leader>td", function() trouble.toggle("document_diagnostics") end, {desc = "[D]ocument"})
vim.keymap.set("n", "<leader>tq", function() trouble.toggle("quickfix") end, {desc = "[Q]uickfix"})
vim.keymap.set("n", "<leader>tl", function() trouble.toggle("loclist") end, {desc = "[L]oclist"})
vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end, {desc = "Trouble LSP [R]eferences"})

