opts = {}

if vim.env.NVIM_ANDROID ~= "true" then
  print("nit and")
  opts = {
    -- log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      nix = { "alejandra" },
      cs = { "csharpier" },
      go = { "gofmt" },
      python = { "black", "autoflake", "isort" },
      terraform = { "terraform_fmt" },
      typescriptreact = { "biome" },
      typescript = { "biome" },
      javascript = { "biome" },
      css = { "biome" },
      html = { "superhtml" },
      ["*"] = { "codespell" }, -- TODO: check how this works
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      -- lsp_format = "fallback",
      timeout_ms = 750,
    },
    formatters = {
      biome = {
        -- These override repo specific configs (e.g. biome.json)
        -- append_args = {
        --   "--indent-style=space",
        --   "--indent-width=2",
        --   "--format-with-errors=true",
        -- },
      },
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
  }
end

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
  opts = opts,
}
