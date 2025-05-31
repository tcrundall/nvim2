return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "saghen/blink.cmp" },
      { "Decodetalkers/csharpls-extended-lsp.nvim" },
    },
    opts = {
      servers = {
        lua_ls = {},
        gopls = {},
        pyright = {},
        csharp_ls = {},
        bashls = {},
      },
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
        underline = false,     -- underline cause of issue
        virtual_text = true,   -- append issue to end of line as virtual text
        signs = true,          -- add symbol in signs column
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
