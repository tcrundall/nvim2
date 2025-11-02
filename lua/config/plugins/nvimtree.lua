return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      update_focused_file = { enable = false },
      view = { width = 100 },
    })
    local api = require("nvim-tree.api")

    vim.keymap.set("n", "<leader>tt", function()
      api.tree.toggle({ focus = false })
    end, { desc = "[T]ree toggle" })

    vim.keymap.set("n", "<leader>to", function()
      api.tree.open({ find_file = true })
    end, { desc = "[T]ree [O]pen" })

    vim.keymap.set("n", "<leader>tc", function()
      api.tree.close()
    end, { desc = "[T]ree [C]lose" })

    vim.keymap.set("n", "<leader>tl", function()
      api.tree.find_file({ open = true })
    end, { desc = "[T]ree [L]ocate current file" })

    vim.keymap.set("n", "<leader>tf", function()
      api.tree.find_file({ open = true, update_root = true })
    end, { desc = "[T]ree [F]ind current file's dir" })

    vim.keymap.set("n", "<leader>sl", function()
      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")
      local node = api.tree.get_node_under_cursor()
      local cwd
      if node ~= nil then
        if node.type == "file" then
          node = node.parent
        end
        cwd = node.absolute_path
      end

      -- if not in tree, then use buffer's dir
      cwd = cwd or utils.buffer_dir()
      builtin.live_grep({ cwd = cwd })
    end, { desc = "[S]earch in [L]ocal dir" })

    -- -- auto find file in tree
    -- vim.api.nvim_create_autocmd("BufEnter", {
    --   callback = function()
    --     api.tree.find_file()
    --   end,
    -- })
  end,
}
