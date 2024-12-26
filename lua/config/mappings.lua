local map = vim.keymap.set

map("n", "<space><space>x", "<cmd>source<cr>")
map("n", "<space>x", ":.lua<cr>")
map("v", "<space>x", ":lua<cr>")

map("n", "<A-u>", "<cmd>cnext<cr>")
map("n", "<A-i>", "<cmd>cprev<cr>")

map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "<C-W>k")
map("n", "<C-h>", "<C-W>h")
map("n", "<C-l>", "<C-W>l")

map("n", "<esc>", "<cmd>noh<cr>")

map("t", "<esc><esc>", "<C-\\><C-N>")

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
