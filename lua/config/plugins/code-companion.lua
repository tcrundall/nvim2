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
          roles = {
            llm = "CodeCompanion",
            user = "Me",
          },
        },
        inline = {
          adapter = "my_openai",
        },
        cmd = {
          adapter = "my_openai",
        },
        agent = {
          adapter = "my_openai",
          tools = {
            ["editor"] = {
              opts = {
                enabled = true,
              },
            },
          },
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
                  default = vim.env.AI_INLINE_MODEL,
                },
              },
              handlers = {
                ---Set the parameters for the request
                ---@param self CodeCompanion.Adapter
                ---@param params table
                ---@param messages table
                ---@return table
                form_parameters = function(self, params, messages)
                  -- Ensure tool_choice is set properly for agents/tools
                  if params.tools and #params.tools > 0 then
                    params.tool_choice = params.tool_choice or "auto"
                  end
                  return params
                end,
              },
            })
          end,
        },
      },
    })
  end,
}
