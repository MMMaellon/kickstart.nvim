vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set("n", "<leader><leader>", vim.cmd.Ex)
-- vim.keymap.set('n', '<leader><leader>', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true, desc = 'File Browser'} )
-- defined this in telescope instead

-- Toggle in VISUAL mode
vim.keymap.set('x', [[<c-/>]], '<Plug>(comment_toggle_linewise_visual)')

-- from kickstart
-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--Fix Autocomplete in command mode
-- Remap keys for navigating the popup menu in command-line mode
-- Have to be written in this way instead of vim.keymap.set
-- vim.api.nvim_set_keymap('c', '<Up>', 'pumvisible() ? "<Left>" : "<Up>"', { noremap = true, expr = true })
-- vim.api.nvim_set_keymap('c', '<Down>', 'pumvisible() ? "<Right>" : "<Down>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<Left>', 'pumvisible() ? "<Up>" : "<Left>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('c', '<Right>', 'pumvisible() ? "<Down>" : "<Right>"', { noremap = true, expr = true })

-- Disable enter for selecting autocomplete suggestions in input mode
vim.keymap.set('i', '<CR>', '<CR>', { noremap = true, silent = false })

vim.keymap.set({ 'n', 'x', 'v' }, '<c-c>', '"+y')
vim.keymap.set({ 'n', 'x', 'v' }, '<c-v>', function()
  vim.opt.paste = true;
  vim.cmd('normal "+p')
  vim.opt.paste = false;
end, { noremap = true, silent = true }
)
vim.keymap.set({ 'i' }, '<c-v>', '<c-r><c-p>+')
vim.keymap.set({ 'n', 'x', 'v' }, '<c-x>', '"+d')
vim.keymap.set({ 'n', 'x' }, '<m-v>', '<c-v>')



vim.keymap.set('n', [[<c-/>]], function()
  return vim.v.count == 0
      and '<Plug>(comment_toggle_linewise_current)'
      or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true })

-- theprimeagen keymaps
-- move lines with jk
vim.keymap.set({ 'v' }, 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set({ 'v' }, 'K', ":m '<-2<CR>gv=gv")
-- don't deslect when moving lines
vim.keymap.set({ 'v' }, '<', "<gv")
vim.keymap.set({ 'v' }, '>', ">gv")
-- when you append lines with j keep everything in the same place
vim.keymap.set('n', 'J', 'mzJ`z')
-- keep cursor in place while using c-d and c-u
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<PageDown>', '<esc>10jzz')
vim.keymap.set('n', '<PageUp>', '<esc>10kzz')
-- when searching keep cursor in middle of screen
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- prevent Q from starting Ex mode (just type : instead)
vim.keymap.set('n', 'Q', '<nop>')
-- jump to prev/next error/lint thing
-- vim.keymap.set('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_prev<CR>zz')
-- vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lua vim.diagnostic.goto_next()<CR>zz', { desc = "Previous Diagnostic" })
vim.keymap.set('n', '<leader>k', '<cmd>lua vim.diagnostic.goto_prev()<CR>zz', { desc = "Next Diagnostic" })
-- quick find and replace
vim.keymap.set('n', '<leader>s', [[:%s/<C-r><C-w>/<C-r><C-w>/gIc<Left><Left><Left><Left><Space><Backspace>]],
  { desc = 'Auto :s///g replace' })

-- Quickly edit registers
vim.keymap.set('n', [[<leader>"]], function()
    -- Get the current register
    local current_register = vim.fn.getreg(vim.v.register)

    -- Escape single quotes in the register content
    local escaped_content = vim.fn.escape(current_register, "'")

    local edited_content = vim.fn.input({ prompt = 'Edit macro content: ', default = escaped_content, cancelreturn = "" })

    if edited_content == "" then
      return;
    end

    -- Construct the Vimscript command to set the register
    local command = string.format("let @%s = '%s'", vim.v.register, edited_content)
    -- Execute the command
    vim.api.nvim_command(command)
  end,
  { desc = "Edit Register" })
vim.api.nvim_create_user_command('SudoWrite', function()
  vim.cmd('silent! w !pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY tee % >/dev/null') -- Save file using pkexec
  vim.cmd('edit!')  -- Force reload the file
end, {})
