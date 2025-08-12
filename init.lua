-- disable netrw at the very start for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
-- vim.opt.termguicolors = true

require("config.settings")
require("config.lazy")
require("config.mappings")
require("config.usercommands")
require("config.autocmds")
