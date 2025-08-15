return {
  "stevearc/conform.nvim",
  dependencies = {
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
  },
  opts = {
    formatters_by_ft = {
      nix = { "alejandra" },
      cs = { "csharpier" },
      go = { "gofmt" },
      python = { "black", "autoflake", "isort" },
      terraform = { "terraform_fmt" },
      typescriptreact = { "biome" },
      typescript = { "biome" },
      javascript = { "biome" },
      ["*"] = { "codespell" }, -- TODO: check how this works
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 750,
    },
    formatters = {
      black = {
        prepend_args = { "-l", "120" },
      },
      isort = {
        prepend_args = {
          "--multi-line=3",
          "--trailing-comma",
          "--force-grid-wrap",
          "--use-parentheses",
          "--line-width=120",
        },
      },
    },
  },
}
