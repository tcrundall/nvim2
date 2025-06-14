return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return ".venv/bin/python"
        end,
      },
    }

    vim.keymap.set("n", "<leader>b", "<cmd>DapToggleBreakpoint<cr>")
    vim.keymap.set("n", "<F2>", "<cmd>DapStepInto<cr>")
    vim.keymap.set("n", "<F3>", "<cmd>DapStepOver<cr>")
    vim.keymap.set("n", "<F4>", "<cmd>DapStepOut<cr>")
    vim.keymap.set("n", "<F5>", "<cmd>DapContinue<cr>")

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
    vim.keymap.set("n", "<Leader>b", function()
      require("dap").toggle_breakpoint()
    end)
    vim.keymap.set("n", "<Leader>B", function()
      require("dap").set_breakpoint()
    end)
    vim.keymap.set("n", "<Leader>lp", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end)
    vim.keymap.set("n", "<Leader>dr", function()
      require("dap").repl.open()
    end)
    vim.keymap.set("n", "<Leader>dl", function()
      require("dap").run_last()
    end)
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      require("dap.ui.widgets").hover()
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
