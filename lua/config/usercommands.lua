vim.api.nvim_create_user_command("W", "w", { desc = "Write even if command typo" })

local openApiViewer = function(opts)
  local filename = vim.fn.expand("%:t")  -- 't' = only file name
  local extension = vim.fn.expand("%:e") -- 'e' = only extension
  local filenameWithoutExtension = filename:gsub("." .. extension, "")
  vim.fn.execute("!openapi-viewer % &")
  vim.fn.execute("!open http://localhost:3000/" .. filenameWithoutExtension .. " &")
end

vim.api.nvim_create_user_command("OpenApiViewer", function(opts)
  openApiViewer(opts)
end, {})
