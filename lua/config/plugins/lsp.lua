local bash_ls_settings = {
  settings = {
    bashIde = {
      shfmt = {
        caseIndent = true,
      },
    },
  },
}

local function install_required_executables(servers)
  local executables = vim.tbl_keys(servers)
  executables = vim.tbl_extend("force", executables, {
    "stylua",
    -- "csharp-language-server", -- manually install on environments with dotnet
    "bash-language-server",
    "lua-language-server",
    "shfmt",
  })
  local not_executables = {
    "csharp_ls",
    "bashls",
    "lua_ls",
    "cmake",
    "clangd", -- not supported on arm
  }
  executables = vim.tbl_filter(function(element)
    return not vim.tbl_contains(not_executables, element)
  end, executables)

  require("mason-tool-installer").setup({
    ensure_installed = executables,
  })
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
      servers = {
        bashls = bash_ls_settings,
        clangd = {},
        cmake = {},
        csharp_ls = {},
        gopls = {},
        lua_ls = {},
        nil_ls = {},
        pyright = {},
        zls = {},
      },
    },
    config = function(_, opts)
      -- nixos manages its own installations
      if vim.env.HOST_NAME ~= "nixos" then
        install_required_executables(opts.servers)
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
