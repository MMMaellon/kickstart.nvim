return {
	"Issafalcon/lsp-overloads.nvim",
	event = "LspAttach",
	config = function()
		-- vim.keymap.set({ "n" }, "<c-k>", "f(a<cmd>LspOverloads signature<CR>", { silent = true })
		vim.keymap.set("n", "<C-k>", function()
			local ok = pcall(vim.cmd, "normal! f(")
			if ok then
				vim.cmd("startinsert!")
			else
				vim.cmd("startinsert")
			end
			vim.cmd("LspOverloads signature")
		end, { silent = true })
		vim.keymap.set({ "i" }, "<c-k>", "<cmd>LspOverloads signature<CR>", { silent = true })
		require("lsp-overloads").setup()
	end
}
