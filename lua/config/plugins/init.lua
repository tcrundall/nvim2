return {
  "catppuccin/nvim", -- for my favourite daymode, catppuccin-frappe
  {
    "folke/tokyonight.nvim",
    lazy = false,  -- load on startup
    priority = 1000, -- load first
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
    keys = {
      {
        "<leader>thd",
        function()
          vim.cmd.colorscheme("tokyonight-night")
          vim.cmd.colorscheme("tokyonight-night")
        end,
      },
    },
  },
  {
    "catppuccin/nvim",
    opts = {},
    keys = {
      {
        "<leader>thl",
        function()
          vim.cmd.colorscheme("catppuccin-latte")
          vim.cmd.colorscheme("catppuccin-latte")
        end,
      },
    },
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
      { "<leader>gs", "<cmd>Git<cr>",                      desc = "[G]it [S]tatus" },
      { "<leader>gl", "<cmd>Git log -n 100<cr><C-W><S-L>", desc = "[G]it [L]og" },
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
  },
}
