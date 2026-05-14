return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim",           lazy = true },
		{ "mason-org/mason-lspconfig.nvim", lazy = true },
		"j-hui/fidget.nvim",
		"mhartington/formatter.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "Issafalcon/lsp-overloads.nvim", lazy = true },
		{ "seblyng/roslyn.nvim",           lazy = true },
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require('mason').setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry", --Provides roslyn.nvim
			},
		})
		local mason_lspconfig = require 'mason-lspconfig'

		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local bufnr = event.buf

				local nmap = function(keys, func, desc)
					if desc then
						desc = 'LSP: ' .. desc
					end
					vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
				end

				nmap('<leader>r', vim.lsp.buf.rename, '[R]e[n]ame')
				nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

				nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
				nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
				nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
				nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
				nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

				nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
				nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
				nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
				nmap('<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, '[W]orkspace [L]ist Folders')

				nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

				if client and client.server_capabilities.signatureHelpProvider then
					require('lsp-overloads').setup(client, {})
					nmap('<C-s>', ":LspOverloadsSignature<CR>", 'Signature Documentation')
				else
					nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')
				end
			end,
		})

		local function lsp_format()
			vim.lsp.buf.format({
				filter = function(c)
					-- Add any other "helper" LSPs to this list
					return c.name ~= "typos_lsp"
				end,
				bufnr = bufnr,
				async = false,
			})
		end


		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_create_user_command('LspFormat', lsp_format, { desc = 'Format current buffer with LSP' })

		vim.keymap.set('n', '<leader>cf', lsp_format, { noremap = true, desc = '[F]ormat' })

		vim.api.nvim_create_user_command('LspInfo', function()
			vim.cmd('checkhealth vim.lsp')
		end, { desc = "List LSPs attached to current buffer" })

		vim.api.nvim_create_user_command('LspLog', function()
			vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
			vim.bo.readonly = true
			vim.bo.modifiable = false
		end, { desc = "List LSPs attached to current buffer" })

		local lsps = {
			rust_analyzer = {
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true
				},
			},
			pyright = {

			},
			marksman = {
				cmd = { "marksman", "server" },
				root_markers = { ".marksman.toml", ".git", ".root" },
				filetypes = { "markdown", "markdown.mdx" },
			},
			typos_lsp = {

			},
			lua_ls = {

			},
			gopls = {
			},
			roc_ls = {

			},
			elmls = {

			},
			bashls = {

			},
			fish_lsp = {

			},
			ts_ls = {
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
			},
			roslyn = {
				cmd = {
					"roslyn",
					"--logLevel=Information",
					"--extensionLogDirectory=" .. vim.fn.stdpath("state") .. "/roslyn",
					"--stdio",
				},
				root_markers = { "*.sln", "*.csproj", "omnisharp.json" },
				filetypes = { "cs", "vb" },
			}
		}

		-- Ensure the servers above are installed

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- Ensure mason-lspconfig installs the servers defined in your `lsps` table *except* Roslyn which isn't provided by Mason
		local mason_ensure_installed = vim.tbl_filter(function(server)
			return server ~= "roslyn"
		end, vim.tbl_keys(lsps))

		mason_lspconfig.setup({
			ensure_installed = mason_ensure_installed,
		})

		-- Configure all standard servers using the native API
		for server_name, config in pairs(lsps) do
			vim.lsp.config(server_name, {
				cmd = config.cmd,
				capabilities = capabilities,
				settings = config.settings or config,
				root_markers = config.root_markers,
				filetypes = config.filetypes,
			})
		end

		-- Enable all servers
		vim.api.nvim_create_autocmd("FileType", {
			desc = "Automated LSP filegate",
			callback = function()
				-- This enables all configured LSPs.
				-- Neovim's native engine will only actually START the ones
				-- that match the current file's type and root markers.
				vim.lsp.enable(vim.tbl_keys(lsps))
			end,
		})

		require("mason-tool-installer").setup {
			ensure_installed = {
				'black',
				'gopls',
			}
		}

		require("formatter").setup {
			filetype = {
				python = {
					require("formatter.filetypes.python").black
				},
			}
		}
	end
}
