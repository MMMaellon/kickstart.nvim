--Highlight Errors in RED
vim.cmd 'highlight SpellBad guifg=#FF4136  guibg=#FF4136'
vim.cmd 'highlight Error guifg=#FF4136  guibg=#FF4136'
vim.cmd 'highlight LspDiagnosticsDefaultError guifg=#FF4136  guibg=#85144b'
vim.cmd 'highlight LspDiagnosticsUnderlineError guifg=#FF4136  guibg=#85144b'



-- return {
-- 	'NLKNguyen/papercolor-theme',
-- 	priority = 1001,
-- 	config = function()
-- 		vim.cmd.colorscheme 'papercolor'
-- 	end,
-- }
-- return {
-- 	"bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1001,
-- 	config = function()
-- 		vim.cmd.colorscheme 'moonfly'
-- 	end
-- }
return {
	'navarasu/onedark.nvim',
	lazy = false,
	priority = 1001,
	style = 'darker',
	config = function()
		require('onedark').setup {style = 'darker'}
		require('onedark').load()
		vim.cmd.colorscheme 'onedark'
	end
}
