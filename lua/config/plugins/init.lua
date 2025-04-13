return {
  "catppuccin/nvim", -- for my favourite daymode, catppuccin-frappe
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- load on startup
    priority = 1000, -- load first
    config = function()
      vim.cmd.colorscheme("tokyonight")
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
    config = function()
      vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "[G]it [S]tatus" })
      vim.keymap.set("n", "<leader>gl", "<cmd>Git log -n 100<cr><C-W><S-L>", { desc = "[G]it [L]og" })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        current_line_blame = true,
        max_file_length = 5000,
      })
    end,
  },
}
