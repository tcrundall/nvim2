if vim.env.NVIM_ANDROID == "true" then
  return {}
end

return {
  "wesleimp/stylua.nvim",
  dependencies = {
    -- TODO: replace deprecated nvim-lspconfig reference with suggestion.
    -- Will no longer work with nvim-lspconfig v3.0
    "neovim/nvim-lspconfig",
  },
  config = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.lua" },
      callback = function()
        require("stylua").format()
      end,
    })
  end,
}
