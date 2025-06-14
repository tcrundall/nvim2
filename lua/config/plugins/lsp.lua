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
  -- csharp_ls is setup in ./csharpls_extended.lua
  gopls = {},
}

local nix_servers = {
  nil_ls = {},
}

local servers = {}
servers = vim.tbl_extend("force", servers, base_servers)
if vim.env.NVIM_FLOWER == "true" then
  servers = vim.tbl_extend("force", servers, flower_servers)
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
      { "j-hui/fidget.nvim",                       opts = {} },
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

          if client:supports_method("textDocument/typeDefinition") then
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition)
          end

          -- if client:supports_method("textDocument/codeAction") then
          --   -- Create a keymap for vim.lsp.buf.code_action
          -- end
          -- if client:supports_method("textDocument/rename") then
          --   -- Create a keymap for vim.lsp.buf.rename()
          -- end
          -- if client:supports_method("textDocument/implementation") then
          --   -- Create a keymap for vim.lsp.buf.implementation
          -- end
        end,
      })

      -- :help vim.diagnostic.Opts
      vim.diagnostic.config({
        underline = false,                                                    -- underline cause of issue
        virtual_text = { severity = { min = vim.diagnostic.severity.HINT } }, -- append issue to end of line as virtual text
        signs = { severity = { min = vim.diagnostic.severity.HINT } },        -- add symbol in signs column
        virtual_lines = false,                                                -- describe issue in virutal lines below
        float = {
          border = "double",
        },
        update_in_insert = true,
        severity_sort = true,
        jump = {
          float = true,
          severity = { min = vim.diagnostic.severity.HINT },
        },
      })

      local diagnostic_hints_enable = true

      vim.api.nvim_create_user_command("ToggleHints", function()
        local diagnostic_hints_opts = {}
        diagnostic_hints_enable = not diagnostic_hints_enable
        print("Hints enabled: " .. tostring(diagnostic_hints_enable))

        if diagnostic_hints_enable then
          diagnostic_hints_opts = {
            virtual_text = {
              severity = { min = vim.diagnostic.severity.HINT },
            },
            signs = {
              severity = { min = vim.diagnostic.severity.HINT },
            },
            jump = {
              float = true,
              severity = { min = vim.diagnostic.severity.HINT },
            },
          }
        else
          diagnostic_hints_opts = {
            virtual_text = {
              severity = { min = vim.diagnostic.severity.WARN },
            },
            signs = {
              severity = { min = vim.diagnostic.severity.WARN },
            },
            jump = {
              float = true,
              severity = { min = vim.diagnostic.severity.WARN },
            },
          }
        end

        vim.diagnostic.config(diagnostic_hints_opts)
      end, {})
    end,
  },
}
