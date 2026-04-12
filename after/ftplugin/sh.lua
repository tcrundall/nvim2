vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader><leader>x",
  "<cmd>w<cr><cmd>!bash %<cr>",
  { desc = "e[X]ecute current bash file" }
)
