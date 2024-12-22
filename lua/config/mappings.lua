vim.api.nvim_set_keymap("n", "<space><space>x", "<cmd>source<cr>", {})
vim.api.nvim_set_keymap("n", "<space>x", ":.lua<cr>", {})
vim.api.nvim_set_keymap("v", "<space>x", ":lua<cr>", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text on yank",
  group = vim.api.nvim_create_augroup("text-yank-highlight", {clear=true}),
  callback = function()
    vim.highlight.on_yank()
  end
})
