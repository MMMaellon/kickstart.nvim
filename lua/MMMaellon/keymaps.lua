vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set("n", "<leader><leader>", vim.cmd.Ex)
vim.keymap.set('n', '<leader><leader>', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })
-- Toggle in VISUAL mode
vim.keymap.set('x', [[<c-/>]], '<Plug>(comment_toggle_linewise_visual)')

-- from kickstart
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--Fix Autocomplete in command mode
-- Remap keys for navigating the popup menu in command-line mode
-- Have to be written in this way instead of vim.keymap.set
vim.api.nvim_set_keymap('c', '<Up>', 'pumvisible() ? "<Left>" : "<Up>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<Down>', 'pumvisible() ? "<Right>" : "<Down>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<Left>', 'pumvisible() ? "<Up>" : "<Left>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<Right>', 'pumvisible() ? "<Down>" : "<Right>"', { noremap = true, expr = true })

-- Disable enter for selecting autocomplete suggestions in input mode
vim.keymap.set('i', '<CR>', '<CR>', { noremap = true, silent = false })

vim.keymap.set({ 'n', 'x' }, '<c-c>', '"+y')
vim.keymap.set({ 'n', 'x' }, '<c-v>', '"+p')
vim.keymap.set({ 'n', 'x' }, '<c-x>', '"+d')
vim.keymap.set({ 'n', 'x' }, 'y', '"+y')
vim.keymap.set('n', 'p', '"+p')

vim.keymap.set('n', [[<c-/>]], function()
  return vim.v.count == 0
      and '<Plug>(comment_toggle_linewise_current)'
      or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true })
