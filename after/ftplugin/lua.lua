vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

local bmap = vim.api.nvim_buf_set_keymap

bmap(0, "n", "<leader><leader>x", "<cmd>w<cr><cmd>.lua<cr>", { desc = "e[X]ecute current lua file" })
bmap(0, "v", "<space>x", ":lua<cr>", {})
