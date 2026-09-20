local notes_dir = vim.env.NOTES_DIR or "~/notes/"
local next_actions_file = vim.env.NEXT_ACTIONS_FILE or "~/notes/next-actions.md"

local function add_to_in_basket()
  vim.ui.input({ prompt = "topic" }, function(input)
    local filename = notes_dir .. "/_in-basket/" .. input:lower():gsub(" ", "-") .. ".md"
    local title = "# " .. input
    vim.fn.writefile({ title }, filename)
    local bufnr = vim.fn.bufadd(filename)
    vim.api.nvim_open_win(bufnr, true, { split = "below" })
  end)
end

vim.api.nvim_create_user_command("InBasket", add_to_in_basket, {})

return {
  "tcrundall/gtd.nvim",
  opts = {
    notes_dir = notes_dir,
    next_actions_file = next_actions_file,
  },
  keys = {
    { "<leader>ea", "<cmd>vsplit " .. next_actions_file .. "<cr>", mode = "n" },
    { "<a-t>", "<cmd>GtdToggleTargetAction<cr>", mode = "n" },
    { "<a-c>", "<cmd>GtdToggleCheck<cr>", mode = "n" },
    { "<leader>ei", "<cmd>InBasket<cr>", mode = "n" },
  },
}
