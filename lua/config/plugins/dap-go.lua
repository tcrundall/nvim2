return {
  "leoluz/nvim-dap-go",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("dap-go").setup({
      tests = { verbose = true },
      redirectOutput = true,
    })
  end,
}
