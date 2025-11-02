if vim.env.NVIM_ANDROID == "true" then
  return {}
end

return {
  "Decodetalkers/csharpls-extended-lsp.nvim",
  config = function()
    -- TODO: replace deprecated nvim-lspconfig reference with suggestion.
    -- Will no longer work with nvim-lspconfig v3.0
    vim.lsp.config("csharp_ls", { cmd = { "csharp-ls-0.16.0-patched" } })
    require("csharpls_extended").buf_read_cmd_bind()
  end,
}
