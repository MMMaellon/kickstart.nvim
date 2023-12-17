local bufferline = require('bufferline')
bufferline.setup{
  options = {
    style_preset = bufferline.style_preset.no_italic,
    indicator = {
      style = 'underline',
    },
    separator_style = "slant",
    color_icons = true,
    right_mouse_command = nil,
    middle_mouse_command = "bdelete! %d",
    diagnostics = "nvim_lsp",
    -- mode = "tabs",
  },
  highlights = {},
}

require('which-key').register {
  ['<leader><tab>'] = { name = 'Tabs', _ = 'which_key_ignore'},
}

vim.keymap.set( {'n', 'v'}, '<leader><Tab><Tab>', function() vim.cmd(':BufferLinePick') end, {desc = 'Select Tab'})
vim.keymap.set( {'n', 'v'}, '<leader><Tab>p', function() vim.cmd(':BufferLineTogglePin') end, {desc = 'Pin Tab'})
vim.keymap.set( {'n', 'v'}, '<leader><Tab>n', function() vim.cmd(':enew') end, {desc = 'New Tab'})
vim.keymap.set( {'n', 'v'}, '<leader><Tab>q', function() vim.cmd(':bd') end, {desc = 'Close Tab'})
vim.keymap.set( {'n', 'v'}, '<leader><Tab>o', function() require('close_buffers').wipe({ type = 'hidden', force = true }) end, {desc = 'Close Other Tabs'})
vim.keymap.set( {'n', 'v'}, '<leader><Tab>O', function() vim.cmd(':BufferLineCloseOthers') end, {desc = 'Close All Other Tabs'})
vim.keymap.set( {'n', 'v'}, '<leader><Tab><Left>', function() vim.cmd(':BufferLineCyclePrev') end, {desc = 'Previous Tab'})
vim.keymap.set( {'n', 'v'}, '<leader><Tab><Right>', function() vim.cmd(':BufferLineCycleNext') end, {desc = 'Next Tab'})
