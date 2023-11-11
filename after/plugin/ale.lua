-- Set global ALE fixers
vim.api.nvim_set_var('ale_fixers', {
    ['*'] = { 'prettier', 'remove_trailing_lines', 'trim_whitespace'},
})

vim.keymap.set( {'n', 'v'}, '<leader>af', function() vim.cmd(':ALEFix') end, {desc = 'ALE [F]ix'})
require('which-key').register {
  ['<leader>a'] = { name = '[A]LE', _ = 'which_key_ignore' },
}
