return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      group = vim.api.nvim_create_augroup("dap-py", {}),
      pattern = "*.py",
      callback = function()
        print("In python autocommand")
        require("dap-python").setup("python3", {
          include_configs = true,
          redirectOutput = true,
          showReturnValue = true,
          justMyCode = false,
        })

        vim.keymap.set("n", "<leader>dm", function()
          require("dap-python").test_method({ test_runner = "pytest" })
        end, { desc = "[D]ebug: python [M]ethod" })

        vim.keymap.set("n", "<leader>dc", function()
          require("dap-python").test_class({ test_runner = "pytest" })
        end, { desc = "[D]ebug: python [C]lass" })
      end,
    })

    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "", numhl = "" })

    -- TODO: Get auto completion to trigger automatically
    -- au FileType dap-repl lua require('dap.ext.autocompl').attach()

    vim.keymap.set("n", "<F2>", function()
      require("dap").step_into()
    end)
    vim.keymap.set("n", "<F3>", function()
      require("dap").step_over()
    end)
    vim.keymap.set("n", "<F4>", function()
      require("dap").step_out()
    end)
    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end)
    vim.keymap.set("n", "<F6>", function()
      require("dap").close()
    end)
    vim.keymap.set("n", "<F9>", function()
      dap.focus_frame()
    end)
    vim.keymap.set("n", "<F10>", "<cmd>DapRestartFrame<cr>")
    vim.keymap.set("n", "<Leader>b", function()
      require("dap").toggle_breakpoint()
    end)
    vim.keymap.set("n", "<leader>B", function()
      local condition = vim.fn.input("Condition: ")
      print("Received condition " .. condition)
      dap.set_breakpoint(condition)
    end)
    vim.keymap.set("n", "<Leader>lp", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end)
    vim.keymap.set("n", "<Leader>dr", function()
      require("dap").repl.toggle()
    end)
    vim.keymap.set("n", "<Leader>dl", function()
      require("dap").run_last()
    end)
    vim.keymap.set("n", "<Leader>du", function()
      require("dap").up()
    end)
    vim.keymap.set("n", "<Leader>dd", function()
      require("dap").down()
    end)
    vim.keymap.set({ "n", "v" }, "<Leader>dt", function()
      require("dap").run_to_cursor()
    end)
    vim.keymap.set({ "n", "v" }, "<Leader>dk", function()
      require("dap.ui.widgets").hover()
    end)
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      require("dap").focus_frame()
    end)
    vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
      require("dap.ui.widgets").preview()
    end)
    vim.keymap.set("n", "<Leader>df", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set("n", "<Leader>ds", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end)
  end,
}
