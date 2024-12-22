return {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme "tokyonight"
    end
  },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require("mini.statusline").setup()
    end
  },
  {
    'tpope/vim-fugitive',
  },
}
