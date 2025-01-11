-- local history = require("project_nvim.utils.history")
-- local function normalise_path(path_to_normalise)
--   local normalised_path = path_to_normalise:gsub("\\", "/"):gsub("//", "/")
--
--   if vim.fn.has('win32') or vim.fn.has('wsl') then
--     normalised_path = normalised_path:sub(1, 1):lower() .. normalised_path:sub(2)
--   end
--
--   return normalised_path
-- end
-- local function is_parent_path(parent, child)
--   -- Make sure both paths are absolute
--   parent = normalise_path(parent)
--   child = normalise_path(child)
--
--   -- Add a trailing slash to the parent path if it doesn't have one
--   if not parent:match("/$") then
--     parent = parent .. "/"
--   end
--
--   -- Check if the child path starts with the parent path
--   if child:sub(1, #parent) == parent then
--     return true
--   else
--     return false
--   end
--   -- return false
-- end
--
-- local print_project_path = function(buffer_path)
--   if not buffer_path then
--     return buffer_path
--   end
--   local dir = vim.fs.dirname(buffer_path)
--   -- for _, project in ipairs(history.session_projects) do
--   --   -- print("comparing ", project, " and ", dir)
--   --   if is_parent_path(project, dir) then
--   --     -- dir = vim.fs.basename(project)
--   --     dir = dir:sub(#project + 1, #dir)
--   --     break
--   --   end
--   -- end
--
--   return table.concat({
--     vim.fs.basename(buffer_path),
--     " (",
--     dir,
--     ")"
--   })
-- end

local base_path = function(buffer_path)
  if not buffer_path then
    return buffer_path
  end
  local dir = vim.fs.dirname(buffer_path)
  return table.concat({
    "(",
    dir,
    ")"
  })
end

local clients_lsp = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if next(clients) == nil then
    return ''
  end

  local c = {}
  for _, client in pairs(clients) do
    if (client.name ~= 'typos_lsp') then
      table.insert(c, client.name)
    end
  end
  return table.concat(c, ', ')
end

local just_arrow = function()
  return ""
end

local custom_ayu = require('lualine.themes.ayu_mirage')

-- Change the background of lualine_c section for normal mode
custom_ayu.normal.c.bg = '#171c22'


require('lualine').setup(
  {
    options = {
      icons_enabled = true,
      theme = custom_ayu,
      component_separators = '',
      -- section_separators = '',
    },
    sections = {
      -- lualine_a = {
        -- {'mode',
        --   color = {fg = 'black'},
        -- }
      -- },
      lualine_b = {
        {
          'filename',
          path = 0,
          padding = { left = 2, right = 1 },
          -- color = {bg = "272d38"}
        },
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          fmt = base_path,
          -- color = {bg = "171d28"}
          -- padding = 0,
          -- color = {fg = "grey"}
        }
      },
      lualine_x = {
        {
          'branch',
          -- color = {bg = "171d28"},
        }
        ,
        {
          'diff',
          -- color = {bg = "171d28"},
        }
        ,
        {
          'diagnostics',
          -- color = {bg = "171d28"},
        }
        ,
      },
      lualine_y = {
        'filetype',
        {
          clients_lsp,
          -- padding = 0
          padding = { left = 0, right = 1 },
        },
      },
      lualine_z = {
        {
          "progress",
        } ,
        -- {
        --   just_arrow,
        --   padding = 0,
        -- } ,
        {
          'location',
        } ,
      }
    },
    inactive_sections = {
      lualine_b = {
        {
          'filename',
          path = 0,
          -- color = 'lualine_c_normal',
          color = {gui = "bold", fg = "607080"},
          padding = { left = 2, right = 1 },
        },
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          fmt = base_path,
          -- color = 'lualine_c_normal',
          color = {fg = "607080"},
          padding = 0,
        }
      }
    }
  }
)
