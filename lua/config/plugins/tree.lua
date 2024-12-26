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
    })

    vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", { desc = "[T]ree toggle" })
    vim.keymap.set("n", "<leader>tl", function()
      require("nvim-tree.api").tree.find_file({ open = true })
    end, { desc = "[T]ree [L]ocate current file" })
    vim.keymap.set("n", "<leader>tf", function()
      require("nvim-tree.api").tree.find_file({ open = true, update_root = true })
    end, { desc = "[T]ree [F]ocus current file's dir" })

    vim.keymap.set("n", "<leader>sl", function()
      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")
      local node = require("nvim-tree.api").tree.get_node_under_cursor()
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
  end,
}
