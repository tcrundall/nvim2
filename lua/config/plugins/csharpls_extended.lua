return {
  "Decodetalkers/csharpls-extended-lsp.nvim",
  config = function()
    require("lspconfig").csharp_ls.setup({})
    require("csharpls_extended").buf_read_cmd_bind()
  end,
}
