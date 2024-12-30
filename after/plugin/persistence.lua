vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"


vim.keymap.set("n", "<leader>fs", function() require("persistence").select() end)
vim.keymap.set("n", "<leader>S", function() require("persistence").load() end)
