-- Profiling
if vim.env.PROF then
	-- example for lazy.nvim
	-- change this to the correct path for your plugin manager
	local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
	vim.opt.rtp:append(snacks)
	Profiler = require("snacks.profiler")
	Profiler.startup({
		startup = {
			event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
			-- event = "UIEnter",
			-- event = "VeryLazy",
		},
	})
end

-- My Stuff
require('MMMaellon')

-- Plugin Manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

	-- git stuff
	'tpope/vim-fugitive', --git commands with :G
	'tpope/vim-rhubarb', -- :GBrowse to open git links

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',

	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
	},

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

	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
	},

	-- {
	-- 	-- Add indentation guides even on blank lines
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	-- Enable `lukas-reineke/indent-blankline.nvim`
	-- 	-- See `:help ibl`
	-- 	main = 'ibl',
	-- 	opts = {},
	-- },

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

	-- {
	-- 	'rmagatti/auto-session',
	-- 	opts = {},
	-- },
	-- Lua
	-- {
	-- 	"folke/persistence.nvim",
	-- 	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	-- 	opts = {
	-- 		-- add any custom options here
	-- 		need = 0,
	-- 	}
	-- },
	{
		"olimorris/persisted.nvim",
		lazy = false,
		event = "BufReadPre",
	},

	--allows closing hidden buffers
	{
		'kazhala/close-buffers.nvim'
	},

	{
		'altermo/ultimate-autopair.nvim',
		event = { 'InsertEnter', 'CmdlineEnter' },
		branch = 'v0.6', --recommended as each new version will have breaking changes
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

	-- tabs
	-- {
	-- 	'akinsho/bufferline.nvim',
	-- 	version = "*",
	-- 	dependencies = 'nvim-tree/nvim-web-devicons'
	-- },

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

	-- {
	-- 	-- 'nvimdev/dashboard-nvim',
	-- 	'MMMaellon/dashboard-nvim',
	-- 	event = 'VimEnter',
	-- 	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
	--
	-- },

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
		-- init = function()
		-- 	vim.o.timeoutlen = 500
		-- end,
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
	'mbbill/undotree',

	--OH BABY LSPs
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{
		'j-hui/fidget.nvim',
		tag = 'legacy',
		opts = {}
	}, -- status updates for LSPs
	--formatters
	{ "mhartington/formatter.nvim" },
	--allows me to ensure certain mason tools are installed
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "Issafalcon/lsp-overloads.nvim" },
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		--@module 'roslyn.config'
		--@type RoslynNvimConfig
		opts = {
			-- your configuration comes here; leave empty for default settings
		}
	},
	-- {
	-- 	'VonHeikemen/lsp-zero.nvim',
	-- 	branch = 'v3.x'
	-- },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/cmp-path' },
	{ 'L3MON4D3/LuaSnip' },

	-- {
	-- 	'mawkler/modicator.nvim',
	-- 	dependencies = 'navarasu/onedark.nvim', -- Add your colorscheme plugin here
	-- 	init = function()
	-- 		-- These are required for Modicator to work
	-- 		vim.o.cursorline = true
	-- 		vim.o.number = true
	-- 		vim.o.termguicolors = true
	-- 	end,
	-- 	opts = {}
	-- },


	-- special library for better nvim docs when editing configs
	{ 'folke/neodev.nvim',        opts = {} }, -- opts = {} is the same as calling .setup() later

	-- just for glsl shaders
	{ 'tikhomirov/vim-glsl' },

	{ import = 'MMMaellon/themes' },
})
