vim.cmd([[ autocmd! BufNewFile, BufRead .*shader set ft=glsl ]])
vim.filetype.add({
  extension = {
    shader = 'glsl' 
  }
})
