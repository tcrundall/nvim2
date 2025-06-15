return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
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

    vim.keymap.set("n", "gs", function()
      gitsigns.stage_hunk()
    end, { desc = "[G]it add hunk to [S]tage" })

    vim.keymap.set("n", "gu", function()
      gitsigns.undo_stage_hunk()
    end, { desc = "[G]it [U]ndo last add of hunk to stage" })

    vim.keymap.set("n", "gX", function()
      gitsigns.reset_hunk()
    end, { desc = "[G]it [X]reset current hunk" })

    vim.keymap.set("n", "gn", function()
      gitsigns.nav_hunk("next")
    end, { desc = "[G]it go to [N]ext hunk" })

    vim.keymap.set("n", "gN", function()
      gitsigns.prev_hunk()
    end, { desc = "[G]it go to previous hunk" })

    vim.keymap.set("n", "gp", function()
      gitsigns.prev_hunk()
    end, { desc = "[G]it go to [P]revious hunk" })
  end,
}
