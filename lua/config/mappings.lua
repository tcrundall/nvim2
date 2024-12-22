local map = vim.api.nvim_set_keymap

map("n", "<space><space>x", "<cmd>source<cr>", {})
map("n", "<space>x", ":.lua<cr>", {})
map("v", "<space>x", ":lua<cr>", {})

map("n", "<A-j>", "<cmd>cnext<cr>", {})
map("n", "<A-k>", "<cmd>cprev<cr>", {})

map("n", "<C-j>", "<C-W>j", {})
map("n", "<C-k>", "<C-W>k", {})
map("n", "<C-h>", "<C-W>h", {})
map("n", "<C-l>", "<C-W>l", {})

map("n", "<esc>", "<cmd>noh<cr>", {})

map("t", "<esc><esc>", "<C-\\><C-N>", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text on yank",
  group = vim.api.nvim_create_augroup("text-yank-highlight", {clear=true}),
  callback = function()
    vim.highlight.on_yank()
  end
})
