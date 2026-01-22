if vim.env.NVIM_ANDROID == "true" then
  return {}
end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "my_openai",
        },
        inline = {
          adapter = "my_openai",
        },
        cmd = {
          adapter = "my_openai",
        },
      },
      adapters = {
        http = {
          my_openai = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = vim.env.AI_URL,
                api_key = vim.env.AI_API_KEY,
              },
              schema = {
                model = {
                  default = vim.env.AI_INLINE_MODEL or "gpt-4",
                },
              },
            })
          end,
        },
      },
    })
  end,
}
