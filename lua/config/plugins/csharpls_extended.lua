if vim.env.NVIM_ANDROID == "true" then
  return {}
end

return {
  "Decodetalkers/csharpls-extended-lsp.nvim",
  config = function()
    require("lspconfig").csharp_ls.setup({ cmd = { "csharp-ls-0.16.0-patched" } })
    require("csharpls_extended").buf_read_cmd_bind()
  end,
}
