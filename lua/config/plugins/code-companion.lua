return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "my_openai",
      },
      inline = {
        adapter = "my_openai",
        model = vim.env.AI_INLINE_MODEL,
      },
      cmd = {
        adapter = "my_openai",
      },
    },
    adapters = {
      my_openai = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = vim.env.AI_URL,
            api_key = vim.env.AI_API_KEY,
          },
        })
      end,
    },
  },
}
