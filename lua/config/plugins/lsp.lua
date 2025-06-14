local base_servers = {
  bashls = {
    settings = {
      bashIde = {
        shfmt = {
          caseIndent = true,
        },
      },
    },
  },
  lua_ls = {},
  pyright = {},
  zls = {},
}

local flower_servers = {
  clangd = {},
  cmake = {},
  csharp_ls = {},
  gopls = {},
}

local nix_servers = {
  nil_ls = {},
}

local base_executables = {
  "autoflake",
  "bash-language-server",
  "black",
  "clangd",
  "isort",
  "lua-language-server",
  "pyright",
  "shellcheck",
  "shfmt",
  "stylua",
  "zls",
}

local flower_executables = {
  -- "csharp-language-server", -- easier to install with `dotnet tool install csharp-ls`
  "gopls",
}

local servers = vim.tbl_extend("force", {}, base_servers)
local executables = vim.tbl_extend("force", {}, base_executables)

if vim.env.NVIM_FLOWER == "true" then
  servers = vim.tbl_extend("force", servers, flower_servers)
  executables = vim.tbl_extend("force", executables, flower_executables)
end
if vim.env.NVIM_NIX == "true" then
  servers = vim.tbl_extend("force", servers, nix_servers)
end

return {
  {
    "neovim/nvim-lspconfig",
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
      servers = servers,
    },
    config = function(_, opts)
      -- nixos manages its own installations
      if vim.env.HOST_NAME ~= "nixos" then
        require("mason-tool-installer").setup({
          ensure_installed = executables,
        })
      end

      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end

          if client:supports_method("textDocument/completion") then
            -- Enable auto-completion
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
          end

          if client:supports_method("textDocument/formatting") then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end

          vim.keymap.set("n", "<leader>ca", function()
            vim.lsp.buf.code_action()
          end, {})

          if client:supports_method("textDocument/rename") then
            -- Create a keymap for vim.lsp.buf.rename()
          end
          if client:supports_method("textDocument/implementation") then
            -- Create a keymap for vim.lsp.buf.implementation
          end
        end,
      })

      -- :help vim.diagnostic.Opts
      vim.diagnostic.config({
        underline = false, -- underline cause of issue
        virtual_text = true, -- append issue to end of line as virtual text
        signs = true, -- add symbol in signs column
        virtual_lines = false, -- describe issue in virutal lines below
        float = {
          border = "double",
        },
        update_in_insert = true,
        severity_sort = true,
        jump = {
          float = true,
        },
      })

      local diagnosticModeVerbose = false
      vim.api.nvim_create_user_command("ToggleDiagnosticMode", function()
        if diagnosticModeVerbose then
          diagnosticModeVerbose = false
          vim.diagnostic.config({
            virtual_text = true,
            virtual_lines = false,
            signs = true,
            jump = {
              float = true,
            },
          })
        else
          diagnosticModeVerbose = true
          vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = true,
            signs = false,
            jump = {
              float = false,
            },
          })
        end
      end, {})
    end,
  },
}
