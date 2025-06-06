return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cs = { "csharpier" },
      go = { "gofmt" },
      json = { "jq" },
      python = { "black", "autoflake", "isort" },
      sh = { "shfmt" },
      terraform = { "terraform_fmt" },
      ["*"] = { "codespell" }, -- TODO: check how this works
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
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
      shfmt = {
        prepend_args = { "-i", "4" },
      },
    },
  },
}
