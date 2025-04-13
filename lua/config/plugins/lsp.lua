return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "saghen/blink.cmp" },
    },
    opts = {
      servers = {
        lua_ls = {},
        -- gopls = {},
        pylsp = {},
        -- csharp_ls = {},
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

      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = true,
        underline = false,
        float = {},
        update_in_insert = true,
        severity_sort = true,
        jump = { float = false },
      })

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

      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "python",
      --   callback = function(ev)
      --     vim.lsp.start({
      --       name = "python-lsp",
      --       cmd = { "pylsp" },
      --     })
      --   end,
      -- })
    end,
  },
}
