local notes_dir = vim.env.NOTES_DIR
local next_actions_file = vim.env.NEXT_ACTIONS_FILE

return {
  "tcrundall/gtd.nvim",
  opts = {
    notes_dir = notes_dir,
    next_actions_file = next_actions_file,
  },
  keys = {
    { "<leader>ea", "<cmd>vsplit " .. next_actions_file .. "<cr>", mode = "n" },
  },
}
