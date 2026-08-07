local highlights = require("config.highlights")

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-y>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = vim.fn.expand("$HOME") .. "/.proto/shims/node", -- explicitly use proto's node
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load on startup
    priority = 1000, -- load first
    config = function()
      -- IDK why but without this, sometimes tokyonight-day gets selected
      vim.cmd.colorscheme("tokyonight-day")
      if vim.env.THEME == "DARK_MODE" then
        vim.cmd.colorscheme("tokyonight-night")
        vim.cmd.colorscheme("tokyonight-night")
        highlights.set_dark_highlight_groups()
      end
    end,
    keys = {
      {
        "<leader>thd",
        function()
          vim.cmd.colorscheme("tokyonight-night")
          vim.cmd.colorscheme("tokyonight-night")
          highlights.set_dark_highlight_groups()
        end,
      },
    },
  },
  {
    "catppuccin/nvim",
    opts = {},
    lazy = false, -- load on startup
    priority = 1000, -- load first
    keys = {
      {
        "<leader>thl",
        function()
          vim.cmd.colorscheme("catppuccin-latte")
          vim.cmd.colorscheme("catppuccin-latte")
          highlights.set_light_highlight_groups()
        end,
      },
    },
    config = function()
      if vim.env.THEME == "LIGHT_MODE" then
        vim.cmd.colorscheme("catppuccin-latte")
        vim.cmd.colorscheme("catppuccin-latte")
        vim.cmd.colorscheme("catppuccin-latte")
        highlights.set_light_highlight_groups()
      end
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.statusline").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "[G]it [S]tatus" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "[G]it [B]lame" },
      { "<leader>gl", "<cmd>Git log -n 100<cr><C-W><S-L>", desc = "[G]it [L]og" },
      { "<leader>go", "<cmd>Git log --oneline -n 100<cr><C-W><S-L>", desc = "[G]it log [O]neline" },
      { "<leader>gu", "<cmd>Git fetch | Git rebase | Git push <cr>", desc = "[G]it [U]pdate" },
      { "<leader>gc", "<cmd>w | Git add % | Git commit<cr>", desc = "[G]it [C]ommit" },
      {
        "<leader>gm",
        "<cmd>Git log -n 100 --oneline main..<cr><C-W><S-L>",
        desc = "[G]it log oneline against [m]ain",
      },
      {
        "<leader>gM",
        "<cmd>Git log -n 100 --oneline master..<cr><C-W><S-L>",
        desc = "[G]it log [O]neline against [M]aster",
      },
    },
    cmd = "Git",
    config = function() end,
  },
  {
    "dustinblackman/oatmeal.nvim",
    cmd = { "Oatmeal" },
    keys = {
      { "<leader>om", mode = "n", desc = "Start Oatmeal session" },
    },
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_SplitWidth = 50
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    keys = {
      { "<leader>nn", "<cmd>NoNeckPain<cr>" },
    },
  },
  -- { "nvim-java/nvim-java" },
  {
    "mfussenegger/nvim-jdtls",
  },

  "tpope/vim-abolish", -- handle variations of words in e.g. substituion
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    --- see ~/.local/share/nvim/lazy/render-markdown.nvim/lua/render-markdown/settings.lua
    opts = {
      anti_conceal = {
        enabled = true,
      },
      pipe_table = {
        style = "normal",
      },
      code = {
        conceal_delimiters = false,
        border = "thick",
        -- langauge_border = "*",
        -- above = "-",
        -- below = "-",
      },
    },
  },
}
