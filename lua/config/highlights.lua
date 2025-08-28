vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("DashHighlight", { clear = true }),
  callback = function()
    vim.cmd([[
    syntax match SpecialDashes /[–—]/ display containedin=ALL
    highlight link SpecialDashes Underlined
  ]])
  end,
})
