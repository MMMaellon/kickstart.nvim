return {
	"Issafalcon/lsp-overloads.nvim",
	event = "LspAttach",
	config = function()
		-- vim.keymap.set({ "n" }, "<c-k>", "f(a<cmd>LspOverloads signature<CR>", { silent = true })
		vim.keymap.set("n", "<C-k>", function()
			pcall(vim.cmd, "normal! f(")
			vim.cmd("normal! l")
			vim.cmd("startinsert")
			vim.cmd("LspOverloads signature")
		end, { silent = true })
		vim.keymap.set({ "i" }, "<c-k>", "<cmd>LspOverloads signature<CR>", { silent = true })
		require("lsp-overloads").setup()
	end
}
