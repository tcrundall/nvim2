local base_formatter_executables = {
  { "autoflake",  version = "2.3.1" },
  { "black",      version = "25.1.0" },
  { "isort",      version = "6.0.1" },
  { "shellcheck", version = "v0.10.0" },
  { "shfmt",      version = "v3.11.0" },
  { "stylua",     version = "v2.1.0" },
}

local base_lsp_executables = {
  { "bash-language-server", version = "5.6.0" },
  { "clangd",               version = "20.1.0" },
  { "lua-language-server",  version = "3.14.0" },
  { "pyright",              version = "1.1.402" },
  { "zls",                  version = "0.14.0" },
}

local flower_lsp_executables = {
  -- want to use custom patch of 0.16.0 without annoying start up messages
  -- { "csharp-language-server", version = "0.16.0" }, -- 0.17.0 requires dotnet 9
  { "gopls", version = "v0.18.1" },
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
