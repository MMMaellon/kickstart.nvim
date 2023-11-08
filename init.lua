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
		opts = {
			options = {
				icons_enabled = false,
				theme = 'ayu_mirage',
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = 'ibl',
		opts = {},
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim',             opts = {} },

	-- fast marks
	'theprimeagen/harpoon',

	-- multi-line visual mode
	{
		'mg979/vim-visual-multi',
		branch = 'master',
	},

	{ 'pocco81/auto-save.nvim',            opts = {} },

	{ 'jiangmiao/auto-pairs',              opts = {},         config = function() end },
	-- {
	-- 	    'windwp/nvim-autopairs',
	-- 	    event = "InsertEnter",
	-- 	    opts = {} -- this is equalent to setup({}) function
	-- },

	{ 'jeffkreeftmeijer/vim-numbertoggle', event = 'VeryLazy' },


	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
	},

	{
		'akinsho/toggleterm.nvim',
		version = '*',
		config = true,
	},

	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {
				-- config
			}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},

	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		init = function()
			vim.o.timeoutlen = 0
		end,
		opts = {},
	},

	-- undo tree
	'mbbill/undotree',

	--OH BABY LSPs
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'j-hui/fidget.nvim',                tag = 'legacy', opts = {} }, -- status updates for LSPs

	{ 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },

	-- special library for better nvim docs when editing configs
	{ 'folke/neodev.nvim',                opts = {} }, -- opts = {} is the same as calling .setup() later

	{ import = 'MMMaellon/themes' },
})
