package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/MMMaellon/?.lua"
require("keymaps")
require("options")
