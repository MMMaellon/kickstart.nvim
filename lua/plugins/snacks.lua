return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		image = {

		},
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys =
				{
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "c", desc = "Config", action = ":Telescope file_browser path=~/.config select_buffer=true<CR>" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				}
			},
			sections = {

				{
					section = "terminal",
					cmd = string.format(
						"chafa %s --probe off --symbols block+half+wide+space+ascii --colors full --clear --view-size=48x27 -w 9 --fg-only --bg %s",
						-- "chafa %s --view-size=48x27",
						gif_path, vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
					),
					width = 48,
					height = 27,
					indent = 5,
					padding = 1,
					align = "center",
					enabled = function()
						return vim.o.columns <= 123 and vim.o.lines > 60 or vim.o.columns > 123 and vim.o.columns <= 200
					end
				},
				{
					section = "terminal",
					cmd = string.format(
						"chafa %s --probe off --symbols block+half+wide+space+ascii --colors full --clear --view-size=60x34 -w 9 --fg-only --bg %s",
						vim.fn.stdpath("config") .. "/resources/transparent_fauna_loop_cropped.gif", vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
					),
					width = 60,
					height = 34,
					-- indent = 3,
					padding = 1,
					align = "center",
					enabled = function()
						return vim.o.columns > 200
					end
				},
				{ pane = 2, title = "", section = "keys", gap = 1, padding = 6 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, key = "<space>", label = " ", action = ":Telescope oldfiles" },
				{ section = "startup" },
			}
		},
		indent = {
			enabled = true,
			scope = {
				enabled = true,
				only_scope = true,
				only_current = true,
			},
			indent = {
				only_current = true,
			}
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 1000,
			style = "fancy"
		},
		quickfile = { enabled = true },
		-- scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
