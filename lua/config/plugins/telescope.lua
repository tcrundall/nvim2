return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope [S]earch [W]ord" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Telescope [S]earch [R]esume" })
    vim.keymap.set("n", "<leader>ss", "<cmd>Telescope<cr>", { desc = "Telescope builtins" })

    vim.keymap.set("n", "<leader>ec", function()
      builtin.find_files({ cwd = "~/Repos/nvim2" })
    end)

    vim.keymap.set("n", "<leader>sF", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true,
      })
    end, { desc = "Telescope find files" })
  end,
}
