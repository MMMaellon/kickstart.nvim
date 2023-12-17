-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
-- require('lsp-zero').extend_cmp()
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local words_match_active_entry = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
      vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match(".*" .. cmp.get_active_entry()) ~= nil
end

local custom_complete = function()
  local api = require('cmp.utils.api')
  local keymap = require('cmp.utils.keymap')
  local feedkeys = require('cmp.utils.feedkeys')
  local offset = api.get_cursor()[2]
  local textEdit = cmp.get_selected_entry().completion_item.textEdit
  -- vim.pretty_print(textEdit)
  local numCharsToDelete = 0
  if textEdit.range then
    numCharsToDelete = offset - textEdit.range.start.character
  elseif textEdit.replace then
    -- numCharsToDelete = offset - textEdit.replace.start.character
    return cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
  end
  local charsToType = textEdit.newText
  if numCharsToDelete > 0 then
    feedkeys.call(keymap.backspace(numCharsToDelete) .. charsToType, 'n')
  end
  return false
end

local function cmp_next(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end
local function cmp_prev(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

cmp.setup {
  debug = true,
  preselect = cmp.PreselectMode.None,
  enabled = function()
    -- disable completion in blank lines
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete {},
    ['<Esc>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end, { 's' }),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = function(fallback)
        -- if cmp.visible() and cmp.get_active_entry() then
        --   cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        -- else
        fallback()
        -- end
      end,
    }),
    ["<TAB>"] = cmp.mapping(cmp_next, { 'i', 's', 'c' }),
    ["<S-TAB>"] = cmp.mapping(cmp_prev, { 'i', 's', 'c' }),
    ['<Down>'] = cmp.mapping(cmp_next, { 'i', 's', 'c' }),
    ['<Up>'] = cmp.mapping(cmp_prev, { 'i', 's', 'c' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

cmp.setup.cmdline(':', {
  -- mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

-- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )
