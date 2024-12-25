return {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local harpoon = require("harpoon")
        opts = {
        settings = {
            save_on_toggle = true,
            key = function()
                return vim.loop.cwd()
            end,
        },
        }

        harpoon:setup(opts)

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<A-j>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<A-k>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<A-l>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<A-;>", function() harpoon:list():select(4) end)

        -- vim.keymap.set("n", "<A-u>", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<A-i>", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<A-o>", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<A-p>", function() harpoon:list():select(4) end)

        -- -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
      end
  }
