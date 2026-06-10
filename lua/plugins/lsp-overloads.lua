return {
	"Issafalcon/lsp-overloads.nvim",
	event = "LspAttach",
	config = function()
		require("lsp-overloads").setup()
		vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>LspOverloads signature<CR>", { silent = true })
	end
}
