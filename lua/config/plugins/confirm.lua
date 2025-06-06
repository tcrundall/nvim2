return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- python = { "isort", "black" },
      python = { "black" },
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
    },
  },
}
