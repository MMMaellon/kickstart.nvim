-- [[Terminal]]
require('toggleterm').setup {
  open_mapping = [[<c-`>]],
  autochdir = true,
  persist_mode = true,
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
}

vim.api.nvim_create_augroup("termgroup", {})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  desc = 'Set terminal to insert mode',
  group = 'termgroup',
  pattern = 'term://*',
  callback = function()
    vim.schedule(function()
      vim.cmd(':startinsert')
    end)
  end,
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
