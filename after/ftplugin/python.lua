vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader><leader>x",
  "<cmd>w<cr><cmd>!python3 %<cr>",
  { desc = "e[X]ecute current python file" }
)
