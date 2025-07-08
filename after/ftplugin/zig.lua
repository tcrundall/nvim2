vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

local bmap = vim.api.nvim_buf_set_keymap

bmap(0, "n", "<leader><leader>x", "<cmd>w<cr><cmd>!zig run %<cr>", { desc = "e[X]ecute current zig file" })
bmap(0, "n", "<leader><leader>t", "<cmd>w<cr><cmd>!zig test %<cr>", { desc = "[T]est current zig file" })
