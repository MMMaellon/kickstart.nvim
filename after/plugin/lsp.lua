-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

local on_attach = function(client, bufnr)
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

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  -- vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
  vim.keymap.set('n', '<leader>cf', function()
    vim.api.nvim_command("Format")
    vim.lsp.buf.format()
  end, { noremap = true, desc = '[F]ormat' })

  --- Guard against servers without the signatureHelper capability
  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {})
    nmap('<C-k>', ":LspOverloadsSignature<CR>", 'Signature Documentation')
  else
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  end
end

-- local lsp_zero = require('lsp-zero')

-- lsp_zero.on_attach(function(client, bufnr)
--   -- see :help lsp-zero-keybindings
--   -- to learn the available actions
--   lsp_zero.default_keymaps({ buffer = bufnr })
--
--   on_attach(client, bufnr)
-- end)

-- lsp_zero.extend_lspconfig()

local lsps = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  },
  -- omnisharp = {
  --
  -- },
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
  zls = {

  }
  -- vale_ls = {
  --   init_options = {
  --     configPath = 'C:\\Users\\MMMaellon\\.vale.ini',
  --     syncOnStartup = true,
  --   },
  --   root_dir = function() return require('lspconfig').util.root_pattern('.git') end,
  -- },
  -- ltex = {
  --   settings = {
  --     ltex = {
  --       language = 'en-US',
  --     }
  --   },
  --   root_dir = require('lspconfig').util.root_pattern('.git'),
  --   cmd = "ltex-ls.bat",
  --   single_file_support = true,
  -- },
  -- clangd = {
  --   filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "shader", "cginc", "gdshader", "glsl" },
  -- }
  -- csharp_ls = {
  --
  -- },
  -- typos_ls = {
  --
  -- }
}

-- Apparently there's settings specific to zig formatting
vim.g.zig_fmt_autosave = 0

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = lsps[server_name],
--       filetypes = (lsps[server_name] or {}).filetypes,
--     }
--   end,
-- }


mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(lsps),
  handlers = {
    -- lsp_zero.default_setup,
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = lsps[server_name],
        filetypes = (lsps[server_name] or {}).filetypes,
      }
    end,
  }
}

require("roslyn").setup({
  dotnet_cmd = "dotnet",              -- this is the default
  roslyn_version = "4.8.0-3.23475.7", -- this is the default
  on_attach = on_attach,              -- required
  capabilities = capabilities,        -- required
})

require("mason-tool-installer").setup {
  ensure_installed = {
    'black',
  }
}

require("formatter").setup {
  filetype = {
    python = {
      require("formatter.filetypes.python").black
    },
  }
}

-- require("ltex_extra").setup {
--   server_opts = {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = {
--       ltex = {}
--     }
--   },
-- }
