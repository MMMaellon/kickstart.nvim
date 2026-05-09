return {

	-- git stuff
	'tpope/vim-fugitive', --git commands with :G
	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
		'JoosepAlviste/nvim-ts-context-commentstring',
	},
	build = ':TSUpdate',

	-- git signs in the gutter
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			}
		}
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim',             opts = {} },

	-- fast marks
	{
		'theprimeagen/harpoon',
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim' }
	},

	{
		'pocco81/auto-save.nvim',
		opts = {
			enabled = true,
			execution_message = {
				message = function()
					return ""
				end,
				dim = 0.18,
				cleaning_interval = 1250,
			},
			-- trigger_events = { 'InsertLeave', 'TextChanged' },
			condition = function(buf)
				local fn = vim.fn
				if vim.bo.ft == "harpoon" then
					return false
				end
				if fn.getbufvar(buf, '&modifiable') == 1 then
					return true -- met condition(s), can save
				end
				return false -- can't save
			end,
			write_all_buffers = true,
			debounce_delay = 1000,
		}
	},

	{
		"olimorris/persisted.nvim",
		lazy = false,
		event = "BufReadPre",
		config = function(_, opts)
			local persisted = require("persisted")
			persisted.branch = function()
				local branch = vim.fn.systemlist("git branch --show-current")[1]
				return vim.v.shell_error == 0 and branch or nil
			end
			persisted.setup(opts)
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},

	-- UI improvements
	-- This adds the UI thingy that pops out questions into that nice looking box
	{
		'stevearc/dressing.nvim',
		opts = {},
	},


	{
		'RRethy/vim-illuminate',
		opts = {},
		config = function()
		end,
	},


	{ 'jeffkreeftmeijer/vim-numbertoggle', event = 'VeryLazy' },

	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
	},

	{
		"ahmedkhalf/project.nvim",
		config = function()
			require('telescope').load_extension('projects')
			require('project_nvim').setup {
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "*.sln" },
				-- detection_methods = {"pattern", "lsp"}
			}
		end,
		opts = {},
	},

	-- Terminal
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		config = true,
	},

	-- New Dashboard?
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		--  opts = {
		-- -- your configuration comes here
		-- -- or leave it empty to use the default settings
		-- -- refer to the configuration section below
		-- bigfile = { enabled = true },
		-- dashboard = { enabled = true },
		-- indent = { enabled = true },
		-- input = { enabled = true },
		-- -- notifier = { enabled = true },
		-- quickfile = { enabled = true },
		-- -- scroll = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
		-- },
	},

	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {},
	},

	-- Shows diagnostic error messages
	{
		'folke/trouble.nvim',
		branch = "main", -- IMPORTANT!
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {

		}
	},

	-- undo tree
	{
		'mbbill/undotree',
	},

	--OH BABY LSPs
	-- {
	-- 	'j-hui/fidget.nvim',
	-- 	tag = 'legacy',
	-- 	opts = {}
	-- }, -- status updates for LSPs
	{ 'L3MON4D3/LuaSnip' },

	-- special library for better nvim docs when editing configs
	{ 'folke/neodev.nvim',        opts = {} }, -- opts = {} is the same as calling .setup() later

	-- just for glsl shaders
	{ 'tikhomirov/vim-glsl' },

	{ import = 'MMMaellon/themes' },
}
