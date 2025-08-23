vim.cmd([[ autocmd! BufNewFile, BufRead .*shader, .*compute set ft=glsl ]])
vim.filetype.add({
  extension = {
    shader = 'glsl',
    compute = 'glsl' 
  }
})
