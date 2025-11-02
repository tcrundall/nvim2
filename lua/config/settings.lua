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
_G.get_fold_text = function()
  local line_length = 100
  local n_folded_lines = vim.v.foldend - vim.v.foldstart + 1
  local fold_title = vim.fn.getline(vim.v.foldstart) .. string.rep(" ", line_length)
  local folded_lines_tag = string.format("  + %s lines", n_folded_lines)
  return (string.sub(fold_title, 1, line_length - string.len(folded_lines_tag)) .. folded_lines_tag)
end
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.get_fold_text()"

-- Comment
-- Set conceal for pretty presentation of e.g. markdown
vim.opt.conceallevel = 3

vim.opt.textwidth = 100

-- when searching, ignore case. precede search with `\C` to respect case
vim.opt.ignorecase = true

-- save undo file history
vim.o.undofile = true

-- disable spell checker from caring about capitalizing sentence start
vim.o.spellcapcheck = ""
