vim.api.nvim_create_user_command("W", "w", { desc = "Write even if command typo" })

local openApiViewer = function(opts)
  local filename = vim.fn.expand("%:t") -- 't' = only file name
  local extension = vim.fn.expand("%:e") -- 'e' = only extension
  local filenameWithoutExtension = filename:gsub("." .. extension, "")
  vim.fn.execute("!openapi-viewer % &")
  vim.fn.execute("!open http://localhost:3000/" .. filenameWithoutExtension .. " &")
end

vim.api.nvim_create_user_command("OpenApiViewer", function(opts)
  openApiViewer(opts)
end, {})

local function toggle_checkbox()
  -- TODO: if line doesn't match "\w*- ([(x| )] )?.*" then return
  local states = {
    "checked_box",
    "unchecked_box",
    "no_box",
  }
  local patterns = {
    checked_box = "- %[x%] *",
    unchecked_box = "- %[ %] *",
    no_box = "- ",
  }
  local replacements = {
    checked_box = "- ",
    unchecked_box = "- [x] ",
    no_box = "- [ ] ",
  }

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row_ix = cursor[1]
  local line = vim.api.nvim_get_current_line()

  for _, state in ipairs(states) do
    local start_ix, end_ix = line:find(patterns[state])
    if start_ix ~= nil and end_ix ~= nil then
      line = line:sub(1, start_ix - 1) .. replacements[state] .. line:sub(end_ix + 1)
      vim.api.nvim_buf_set_lines(0, row_ix - 1, row_ix, false, { line })
      return
    end
  end
end

vim.api.nvim_create_user_command("ToggleCheckbox", function()
  toggle_checkbox()
end, {})

vim.keymap.set({ "n", "i" }, "<m-x>", "<cmd>ToggleCheckbox<cr>", { desc = "toggle checkbox" })
