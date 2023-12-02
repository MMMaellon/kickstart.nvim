local history = require("project_nvim.utils.history")
local function normalise_path(path_to_normalise)
  local normalised_path = path_to_normalise:gsub("\\", "/"):gsub("//", "/")

  if vim.fn.has('win32') or vim.fn.has('wsl') then
    normalised_path = normalised_path:sub(1, 1):lower() .. normalised_path:sub(2)
  end

  return normalised_path
end
local function is_parent_path(parent, child)
  -- Make sure both paths are absolute
  parent = normalise_path(vim.fn.fnamemodify(parent, ":p"))
  child = normalise_path(vim.fn.fnamemodify(child, ":p"))

  -- Add a trailing slash to the parent path if it doesn't have one
  if not parent:match("/$") then
    parent = parent .. "/"
  end

  -- Check if the child path starts with the parent path
  return child:sub(1, #parent) == parent
  -- return false
end

local print_project_path = function(path)
  if not path then
    return path
  end
  local dir = vim.fs.dirname(path)
  for _, project in ipairs(history.session_projects) do
    if is_parent_path(project, dir) then
      -- dir = vim.fs.basename( project)
      dir = project
      break
    end
  end

  return table.concat({
    vim.fs.basename(path),
    " (",
    dir,
    ")"
  })
end


require('lualine').setup(
  {
    options = {
      icons_enabled = false,
      theme = 'ayu_mirage',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_c = { {
        'filename',
        path = 0,
        fmt = print_project_path,
        color = 'MiniStatuslineFileInfo'

      } },
    },
    inactive_sections = {
      lualine_c = { {
        'filename',
        path = 0,
        fmt = print_project_path,
        color = '@comment'
      } },
    }
  }
)
