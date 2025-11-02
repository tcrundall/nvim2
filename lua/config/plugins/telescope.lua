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
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
          theme = "ivy",
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
        },
        live_grep = {
          theme = "ivy",
        },
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
    end, {
      desc = "[E]dit [C]onfig files",
    })

    vim.keymap.set("n", "<leader>ep", function()
      builtin.find_files({ cwd = vim.fn.stdpath("data") })
    end, {
      desc = "[E]dit [P]lugin files",
    })

    vim.keymap.set("n", "<leader>en", function()
      builtin.find_files({ cwd = "~/repos/notes" })
    end)

    vim.keymap.set("n", "<leader>sF", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true,
      })
    end, { desc = "Telescope [S]earch all [F]iles" })

    vim.keymap.set("n", "<leader>sx", builtin.current_buffer_fuzzy_find)

    -- Filter live grep for provided filetype
    vim.keymap.set("n", "<leader>sp", function()
      local file_pattern = vim.fn.input("File pattern: ")
      if file_pattern ~= "" then
        builtin.live_grep({ glob_pattern = file_pattern })
      end
    end, { desc = "[S]earch over file [P]attern" })

    vim.keymap.set("n", "<leader>so", function()
      builtin.live_grep({ grep_open_files = true })
    end, { desc = "[S]earch [O]pen files" })
  end,
}
