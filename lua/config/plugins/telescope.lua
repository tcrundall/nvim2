return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key",
            -- ["<C-f>"] = "preview_scrolling_left",
          },
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
        },
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      },
    })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope [S]earch [W]ord" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Telescope [S]earch [R]esume" })
    vim.keymap.set("n", "<leader>ss", "<cmd>Telescope<cr>", { desc = "Telescope builtins" })

    vim.keymap.set("n", "<leader>ec", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end)

    vim.keymap.set("n", "<leader>en", function()
      builtin.find_files({ cwd = "~/Repos/notes" })
    end)

    vim.keymap.set("n", "<leader>sF", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true,
      })
    end, { desc = "Telescope find files" })

    vim.keymap.set("n", "<leader>sx", builtin.current_buffer_fuzzy_find)
  end,
}
