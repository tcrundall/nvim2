return {
  "wesleimp/stylua.nvim",
  config = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.lua" },
      callback = function()
        require("stylua").format()
      end,
    })
  end,
}
