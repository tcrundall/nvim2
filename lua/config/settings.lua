local set = vim.opt

set.number = true
set.relativenumber = true
set.wrap = false

set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true

set.splitbelow = true
set.splitright = true

set.scrolloff = 8

-- keep sign column on to avoid jerking around
set.signcolumn = "yes"

-- if closing without right, prompt for resolution
set.confirm = true

-- set fold method based treesitter parsing
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Comment
-- Set conceal for pretty presentation of e.g. markdown
vim.opt.conceallevel = 3

vim.opt.textwidth = 100

-- when searching, respect case. preceed search with `\c` to ignore case
vim.opt.ignorecase = false
