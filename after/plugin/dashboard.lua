require('dashboard').setup {
  theme = 'hyper',
  config = {
    header = {
      '',
      '',
      '        ⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀  ',
      '      ⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷ ',
      '     ⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿ ',
      '    ⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿ ',
      '  ⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿ ',
      ' ⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿ ',
      ' ⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟ ',
      ' ⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣ ',
      ' ⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾ ',
      ' ⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿ ',
      ' ⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿ ',
      ' ⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿ ',
      ' ⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿ ',
      '  ⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋  ⣾⡌⢠⣿⡿⠃ ',
      ' ⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉            ',
      '',
      '',
    },
    week_header = {
      enable = false,
    },
    shortcut = {
      {
        desc = '󰊳 Update',
        group = '@property',
        action = 'Lazy update',
        key = 'u'
      },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Previous Files',
        group = 'Label',
        action = 'Telescope oldfiles',
        key = 'f',
      },
      {
        desc = ' Telescope',
        group = 'DiagnosticHint',
        action = 'Telescope commands',
        key = 't',
      },
      {
        desc = ' Config',
        group = 'Number',
        action = 'Telescope file_browser cwd=~/AppData/Local/nvim/',
        key = 'c',
      },
    },
    project = { action = function(path)
      print("we got ".. path)
      require('telescope').extensions.file_browser.file_browser({path = path});
    end
    },
  },
}

-- Also I do a fix for recent projects here: https://github.com/nvimdev/dashboard-nvim/issues/347
-- Also Also I just overwrote their projects thing with 'nvim-projects'
-- read function now looks like this:
  -- local function re>ad_project(data)
  --   local res = {}
  --   -- data = string.gsub(data, '%z', '')
  --   -- local dump = assert(loadstring(data))
  --   -- local list = dump()
  --   local list = require('project_nvim').get_recent_projects()
  --   if list then
  --     list = vim.list_slice(list, #list - config.project.limit)
  --   end
  --   for _, dir in ipairs(list or {}) do
  --     dir = dir:gsub(vim.env.HOME, '~')
  --     table.insert(res, (' '):rep(3) .. ' ' .. dir)
  --   end
  --
  --   if #res == 0 then
  --     table.insert(res, (' '):rep(3) .. ' empty project')
  --   else
  --     reverse(res)
  --   end
  --
  --   table.insert(res, 1, config.project.icon .. config.project.label)
  --   table.insert(res, 1, '')
  --   table.insert(res, '')
  --   return res
  -- end
-- function for when you click on a project now looks like this. I just added quotes around the path.
  -- local function map_key(config, key, content)
  --   keymap.set('n', key, function()
  --     local text = content or api.nvim_get_current_line()
  --     local scol = utils.is_win and text:find('%w') or text:find('%p')
  --     text = text:sub(scol)
  --     local path = text:sub(1, text:find('%w(%s+)$'))
  --     path = vim.fs.normalize(path)
  --     if vim.fn.isdirectory(path) == 1 then
  --       vim.cmd('lcd ' .. path)
  --       if type(config.project.action) == 'function' then
  --         config.project.action(path)
  --       elseif type(config.project.action) == 'string' then
  --         local dump = loadstring(config.project.action)
  --         if not dump then
  --           vim.cmd(config.project.action .. "\"" .. path .. "\"")
  --         else
  --           dump(path)
  --         end
  --       end
  --     else
  --       vim.cmd('edit ' .. path)
  --       local root = utils.get_vcs_root()
  --       if not config.change_to_vcs_root then
  --         return
  --       end
  --       if #root > 0 then
  --         vim.cmd('lcd ' .. vim.fn.fnamemodify(root[#root], ':h'))
  --       else
  --         vim.cmd('lcd ' .. vim.fn.fnamemodify(path, ':h'))
  --       end
  --     end
  --   end, { buffer = config.bufnr, silent = true, nowait = true })
  -- end
