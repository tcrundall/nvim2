return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",

  version = "*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      -- Add custom mappings for snippets
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      -- show e.g. function docs alongside copmletion suggestion
      -- use <C-B> and <C-F> to scroll through docs
      documentation = {
        auto_show = true,
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },

    -- this is for when you're typing the signature
    -- signature = {
    --   enabled = true,
    --   window = { show_documentation = true },
    -- },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
