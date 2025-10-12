return {
  "wesleimp/stylua.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    if vim.env.NVIM_ANDROID ~= "true" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua" },
        callback = function()
          require("stylua").format()
        end,
      })
    end
  end,
}
