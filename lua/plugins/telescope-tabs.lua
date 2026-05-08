return {
	'LukasPietzschmann/telescope-tabs',
	config = function()
		require('telescope').load_extension 'telescope-tabs'
		require('telescope-tabs').setup {
		}
	end,
	dependencies = { 'nvim-telescope/telescope.nvim' },
	keys = {
		{
			"<leader>t",
			function() require('telescope-tabs').list_tabs() end,
			desc = '[t] Find Tabs'
		},
	}
}
