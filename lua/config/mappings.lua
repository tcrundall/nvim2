local map = vim.keymap.set

map("n", "<A-u>", "<cmd>cnext<cr>")
map("n", "<A-i>", "<cmd>cprev<cr>")

map("n", "<esc>", "<cmd>noh<cr><cmd>echo ''<cr>")

map("t", "<esc><esc>", "<C-\\><C-N>")

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")

local log_file = vim.env.LOG_FILE or "~/log.md"
map("n", "<leader>el", "<cmd>vs " .. log_file .. "<cr>")
