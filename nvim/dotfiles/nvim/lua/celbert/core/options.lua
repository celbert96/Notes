vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true -- default non-case sensitive search
opt.smartcase = true -- if typing in mixed case, assume match case in search

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- show sign column so that the text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, eol or insert mode start

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true
opt.splitbelow = true
