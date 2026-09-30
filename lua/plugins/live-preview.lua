return {
	'brianhuster/live-preview.nvim',
	dependencies = {
		-- You can choose one of the following pickers
		'nvim-telescope/telescope.nvim',
	},
	config = function()
		local config = require("livepreview.config").config
		local utils = require("livepreview.utils")
		vim.api.nvim_create_user_command('PreviewToggle', function()
			filepath = vim.api.nvim_buf_get_name(0)
			local processes = utils.processes_listening_on_port(config.port)
			if not processes or #processes == 0 then
				vim.cmd.LivePreview("start")
			else
				vim.cmd.LivePreview("close")
			end
		end, { desc = 'Toggle the LivePreview server' })
	end
}
