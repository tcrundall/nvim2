local map = vim.keymap.set

map("n", "<A-u>", "<cmd>cnext<cr>")
map("n", "<A-i>", "<cmd>cprev<cr>")
map("n", "<A-o>", "<cmd>lnext<cr>")
map("n", "<A-p>", "<cmd>lprev<cr>")

map("n", "<esc>", "<cmd>noh<cr><cmd>echo ''<cr>")

map("t", "<esc><esc>", "<C-\\><C-N>")

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")

local log_file = vim.env.GTD_LOG_FILE or "~/log.md"
map("n", "<leader>el", "<cmd>vs " .. log_file .. "<cr>")

local proj_notes_file = vim.env.PROJ_NOTES_FILE or "~/notes-project.md"
map("n", "<leader>epn", "<cmd>vs " .. proj_notes_file .. "<cr>")

local proj_log_file = vim.env.PROJ_LOG_FILE or "~/log-project.md"
map("n", "<leader>epl", "<cmd>vs " .. proj_log_file .. "<cr>")

map("n", "y%", function()
  vim.fn.setreg('"', vim.fn.expand("%"))
end)

-- TODO: Attach these mappings to a group activated and deactivated via user command
-- -- wrapped editing
-- map("n", "j", "gj")
-- map("n", "k", "gk")
-- map("n", "$", "g$")
-- map("n", "0", "g0")
