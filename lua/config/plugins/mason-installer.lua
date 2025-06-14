local base_formatter_executables = {
  "autoflake",
  "black",
  "isort",
  "shellcheck",
  "shfmt",
  "stylua",
}

local base_lsp_executables = {
  "bash-language-server",
  "clangd",
  "lua-language-server",
  "pyright",
  "stylua",
  "zls",
}

local flower_lsp_executables = {
  -- "csharp-language-server", -- easier to install with `dotnet tool install csharp-ls`
  "gopls",
}

local executables = {}
executables = vim.list_extend(executables, base_formatter_executables)
executables = vim.list_extend(executables, base_lsp_executables)

if vim.env.NVIM_FLOWER == "true" then
  executables = vim.list_extend(executables, flower_lsp_executables)
end

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    { "saghen/blink.cmp" },
    { "Decodetalkers/csharpls-extended-lsp.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
  },
  opts = {
    ensure_installed = executables,
  },
  config = function(_, opts)
    local mason_tool_installer = require("mason-tool-installer")
    if vim.env.NVIM_NIX ~= "true" then
      mason_tool_installer.setup(opts)
    end
  end,
}
