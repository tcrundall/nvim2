vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader><leader>x",
  "<cmd>w<cr><cmd>!node %<cr>",
  { desc = "e[X]ecute current typescript file" }
)
