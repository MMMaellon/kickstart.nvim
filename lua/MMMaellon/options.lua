-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- set the title to the filename
vim.o.title = true;

--Indent newlines
vim.o.autoindent = true

-- Allow arrow keys to wrap lines
vim.o.whichwrap = vim.o.whichwrap .. '<,>,[,]'

--line where the cursor is
vim.wo.cursorline = true

--Font
vim.opt.guifont = { 'Fira Code', ':h14' } -- is opt because it only applies to neovide

--Set proper clipboard
vim.opt.clipboard = ''

--Stop continuing comments on new lines
vim.api.nvim_create_autocmd('OptionSet', {
    callback = function()
        vim.opt.formatoptions:remove 'c'
        vim.opt.formatoptions:remove 'r'
        vim.opt.formatoptions:remove 'o'
    end,
    pattern = '*',
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- These next two are needed for omnisharp
-- Enable filetype-based indenting and plugins
vim.cmd("filetype plugin indent on")
-- Enable syntax highlighting
vim.cmd("syntax enable")

--Make Neovide Update in a the background
vim.g.neovide_refresh_rate_idle = 60

-- turn on wordwrap
vim.go.wrap = true;
vim.o.showbreak = '↳ ';
vim.wo.linebreak = true;

--stolen from theprimeagen
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.incsearch = true

vim.opt.scrolloff = 16
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.swapfile = false
vim.opt.backup = false
vim.o.undodir = vim.fn.expand("~/.vim/undo")
vim.opt.undofile = true

vim.opt.colorcolumn = "160"

-- Server for Unity
-- vim.cmd("echo serverstart(\'::1:42069\')")


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
